import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import '/modules/sign_up/pages/doctor_sign_up/doctor_sign_up.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_container.dart';
import '/modules/sign_up/pages/patient_sign_up/patient_sign_up.dart';

class SelectType extends StatelessWidget {
  const SelectType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Image.asset(AppAssets.logo),
          ),
          GestureDetector(
            onTap: () => replaceWidget(
              newPage: PatientSignUp(),
              context: context,
            ),
            child: CustomContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.patientAvatar,
                    height: 0.1.height,
                  ),
                  0.03.width.vSpace,
                  Text(
                    "Patient",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ).hPadding(0.03.width),
          ),
          0.1.height.hSpace,
          GestureDetector(
            onTap: () => replaceWidget(
              newPage: DoctorSignUp(),
              context: context,
            ),
            child: CustomContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.doctorAvatar,
                    height: 0.1.height,
                  ),
                  0.03.width.vSpace,
                  Text(
                    "Doctor",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ).hPadding(0.03.width),
          )
        ],
      ),
    );
  }
}
