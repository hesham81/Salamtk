import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twseef/core/widget/custom_elevated_button.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/patient/pages/patient_home/widget/mixed_text_colors.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Account",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            0.01.height.hSpace,
            MixedTextColors(
              title: "Name",
              value: user!.displayName.toString(),
            ),
            0.01.height.hSpace,
            MixedTextColors(
              title: "Email",
              value: user.email!,
            ),
            0.01.height.hSpace,
            MixedTextColors(
              title: "Phone Number",
              value: user.phoneNumber ?? "No Number Set",
            ),
            0.01.height.hSpace,
            MixedTextColors(
              title: "Medical prescription",
              value: "No Prescription Uploaded",
            ),
            0.1.height.hSpace,
            CustomElevatedButton(
              child: Text(
                "Delete Account",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.primaryColor,
                    ),
              ),
              onPressed: () {},
              btnColor: Colors.red,
            )
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
