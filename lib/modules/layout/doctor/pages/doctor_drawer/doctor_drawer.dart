import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '../../../../../core/providers/app_providers/language_provider.dart';
import '/core/constant/app_assets.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/models/doctors_models/doctor_model.dart';
import '/modules/layout/doctor/pages/doctors_money/pages/doctors_money.dart';
import '/modules/layout/doctor/pages/doctors_money/widget/profile_image_container.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/doctor/pages/doctor_profile/pages/doctor_profile.dart';
import '/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/call_us/pages/call_us.dart';
import '/modules/sign_in/pages/sign_in.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
    var local = AppLocalizations.of(context);
    var provider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            (isLoading)
                ? ProfileImageContainer(
                    name: doctor?.name ?? local!.noName,
                    imageUrl: doctor?.imageUrl ?? AppAssets.doctorAvatar,
                    email: FirebaseAuth.instance.currentUser?.email ??
                        "doctor@gmail.com",
                  )
                : Skeletonizer(
                    enabled: isLoading,
                    child: ProfileImageContainer(
                      name: doctor?.name ?? local!.noName,
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
                        local!.profile,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
                        local.money,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.blackColor,
                            ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () => slideLeftWidget(
                    newPage: CallUs(
                      isPatient: false,
                    ),
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
                        local.callUs,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
                        local.privacy,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.blackColor,
                            ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                CustomDropdown(
                  hintText: (provider.getLanguage == "en") ? "English" : "Arabic",
                  items: [
                    "English",
                    "Arabic",
                  ],
                  onChanged: (p0) {
                    if (p0 == "English") {
                      if (provider.getLanguage != "en") {
                        provider.setLang("en");
                      }
                    } else {
                      if (provider.getLanguage != "ar") {
                        provider.setLang("ar");
                      }
                    }
                  },
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
                        local.logout  ,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
