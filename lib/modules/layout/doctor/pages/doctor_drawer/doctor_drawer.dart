import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/constant/app_assets.dart';
import 'package:salamtk/core/utils/doctors/doctors_collection.dart';
import 'package:salamtk/models/doctors_models/doctor_model.dart';
import 'package:salamtk/modules/layout/doctor/pages/doctors_money/pages/doctors_money.dart';
import 'package:salamtk/modules/layout/doctor/pages/doctors_money/widget/profile_image_container.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/doctor/pages/doctor_profile/pages/doctor_profile.dart';
import '/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/call_us/pages/call_us.dart';
import '/modules/sign_in/pages/sign_in.dart';

class DoctorDrawer extends StatefulWidget {
  const DoctorDrawer({super.key});

  @override
  State<DoctorDrawer> createState() => _DoctorDrawerState();
}

class _DoctorDrawerState extends State<DoctorDrawer> {
  DoctorModel? doctor;
  bool isLoading = true;

  Future<void> _getDoctorsData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    doctor = await DoctorsCollection.getDoctorData(uid: uid);
  }

  @override
  void initState() {
    Future.wait(
      [
        _getDoctorsData(),
      ],
    ).then(
      (value) => setState(() {
        isLoading = true;
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            (isLoading)
                ? ProfileImageContainer(
                    name: doctor?.name ?? "No Name",
                    imageUrl: doctor?.imagePath ?? AppAssets.doctorAvatar,
                    email: FirebaseAuth.instance.currentUser?.email ??
                        "doctor@gmail.com",
                  )
                : Skeletonizer(
                    enabled: isLoading,
                    child: ProfileImageContainer(
                      name: doctor?.name ?? "No Name",
                      imageUrl: doctor?.imagePath ?? AppAssets.doctorAvatar,
                      email: FirebaseAuth.instance.currentUser?.email ??
                          "doctor@gmail.com",
                    ),
                  ),
            Column(
              children: [
                ListTile(
                  onTap: () => slideLeftWidget(
                    newPage: DoctorProfile(),
                    context: context,
                  ),
                  title: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColors.secondaryColor,
                      ),
                      0.01.width.vSpace,
                      Text(
                        "Profile",
                        style:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: AppColors.blackColor,
                                ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () => slideLeftWidget(
                    newPage: DoctorsMoney(),
                    context: context,
                  ),
                  title: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.solidMoneyBill1,
                        color: AppColors.secondaryColor,
                      ),
                      0.01.width.vSpace,
                      Text(
                        "Money",
                        style:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: AppColors.blackColor,
                                ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () => slideLeftWidget(
                    newPage: CallUs(),
                    context: context,
                  ),
                  title: Row(
                    children: [
                      Icon(
                        Icons.call_end_outlined,
                        color: AppColors.secondaryColor,
                      ),
                      0.01.width.vSpace,
                      Text(
                        "Call Us",
                        style:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: AppColors.blackColor,
                                ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.privacy_tip_outlined,
                        color: AppColors.secondaryColor,
                      ),
                      0.01.width.vSpace,
                      Text(
                        "Privacy And Policy",
                        style:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: AppColors.blackColor,
                                ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                CustomElevatedButton(
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.signOutAlt,
                        color: AppColors.primaryColor,
                      ),
                      0.02.width.vSpace,
                      Text(
                        "Logout",
                        style:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                      ),
                    ],
                  ).hPadding(0.05.width),
                  btnColor: Colors.red,
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ).hPadding(0.03.width)
          ],
        ),
      ),
    );
  }
}
