import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/theme/app_colors.dart';
import 'package:salamtk/core/widget/custom_container.dart';

import '../../../../../sign_up/pages/doctor_sign_up/doctor_sign_up.dart';

class JoinUsIcon extends StatelessWidget {
  const JoinUsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => slideLeftWidget(
        newPage: DoctorSignUp(),
        context: context,
      ),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(50),
          border: Border.all(
            color: AppColors.secondaryColor,
            width: 1.1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/9e7ad021598f3e78c30e0dff2aae83f7-removebg-preview.png",
              height: 70,
              width: 70,
            ),
            Spacer(),
            Text(
              "Join To Our Doctors Now",
              style: TextStyle(

                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
