import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoradingPageDesign extends StatelessWidget {
  const OnBoradingPageDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset("assets/images/on_boarding_image_one.svg")
      ],
    );
  }
}
