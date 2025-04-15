import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/models/doctors_models/doctor_model.dart';
import '/modules/layout/doctor/pages/doctor_profile/widget/doctor_profile_component.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  var user = FirebaseAuth.instance.currentUser;
  late DoctorModel? doctor;
  bool isLoading = true;

  Future<void> _getDoctor() async {
    doctor = await DoctorsCollection.getDoctorData(
      uid: user!.uid,
    );
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([
      _getDoctor(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: (isLoading)
          ? CircularProgressIndicator(
              backgroundColor: AppColors.secondaryColor,
            ).center
          : SingleChildScrollView(
              child: Column(
                children: [
                  0.01.height.hSpace,
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      AppAssets.doctorAvatar,
                    ),
                    radius: 80,
                  ).center,
                  0.01.height.hSpace,
                  Text(
                    "Hello ${user?.displayName}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                  ),
                  Text(
                    user?.email ?? "No Email",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.person,
                    content: user?.displayName ?? "No Name",
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.phone_android,
                    content: doctor!.phoneNumber,
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.location_on_outlined,
                    content: doctor!.state,
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.attach_money,
                    content: "${doctor!.price} EGP",
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.description_outlined,
                    content: doctor!.description,
                  ),
                  0.01.height.hSpace,
                  DoctorProfileComponent(
                    icon: Icons.star_border_sharp,
                    content: doctor!.specialist,
                  ),
                ],
              ).hPadding(0.03.width),
            ),
    );
  }
}
