import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/modules/layout/doctor/pages/doctor_home.dart';
import '/core/constant/shared_preference_key.dart';
import '/core/services/local_storage/shared_preference.dart';
import '/modules/layout/patient/pages/patient_home/pages/patient_home.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/align.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? role;
  String? token;

  getRole() async {
    role = await SharedPreference.getString(SharedPreferenceKey.role).then(
      (value) => value,
    );
    setState(() {});
  }

  getToken() async {
    token = await FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }

  @override
  void initState() {
    getRole();
    getToken();
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => (token == null)
              ? PatientHome()
              : (role == "patient")
                  ? PatientHome()
                  : DoctorHome(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FadeInLeft(
            duration: Duration(seconds: 2),
            child: SvgPicture.asset(
              AppAssets.halfCircleLeft,
            ).alignTopLeft(),
          ),
          Image.asset(AppAssets.logo).center,
          FadeInRight(
            duration: Duration(seconds: 2),
            child: SvgPicture.asset(
              AppAssets.halfCircleRight,
            ).alignBottomRight(),
          ),
        ],
      ),
    );
  }
}
