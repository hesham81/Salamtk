import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:route_transitions/route_transitions.dart';
import '/modules/sign_in/pages/sign_in.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/align.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      slideLeftWidget(newPage: SignIn(), context: context);
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
