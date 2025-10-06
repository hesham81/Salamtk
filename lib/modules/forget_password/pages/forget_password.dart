import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/services/snack_bar_services.dart';
import 'package:salamtk/core/utils/auth/auth_collections.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/my_account/pages/change_password.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/my_account/pages/otp_of_change_password.dart';
import 'package:salamtk/modules/otp/page/otp.dart';
import '../../../core/functions/otp_services.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController phoneNumberController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  // Future<void> changes() async {
  //   var result = await AuthCollections.checkIfThePhoneNumberIsExist(
  //     phoneNumber: phoneNumberController.text.trim(),
  //   );
  //   log("The Result is $result");
  // }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.forgetPassword,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppAssets.forgetPassword,
              ),
              0.02.height.hSpace,
              CustomTextFormField(
                hintText: local!.phoneNumber,
                controller: phoneNumberController,
                suffixIcon: Icons.phone_android,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return local.emptyPhone;
                  }

                  final egyptPhoneRegex = RegExp(r'^0(10|11|12|15)\d{8}$');
                  if (!egyptPhoneRegex.hasMatch(value)) {
                    return local.phoneError;
                  }

                  return null;
                },
              ).hPadding(0.03.width),
              0.1.height.hSpace,
              CustomElevatedButton(
                child: Text(
                  local.forgetPassword,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    bool isExist =
                        await AuthCollections.checkIfThePhoneNumberIsExist(
                      phoneNumber: phoneNumberController.text.trim(),
                    );
                    log("Checking If The Phone Number is Available Or Not ${phoneNumberController.text}");
                    log("IS The Exist IS not working $isExist");

                    if (!isExist) {
                      SnackBarServices.showErrorMessage(
                        context,
                        message: local.phoneNumberIsNotExist,
                      );
                      return;
                    }
                    // await OtpServices.sendOtp(
                    //   phoneNumber: phoneNumberController.text,
                    //   lang: 'ar',
                    //   name: "Salamtuk Application",
                    // );
                    slideLeftWidget(
                      newPage: ChangePassword(),
                      context: context,
                    );
                  }
                },
              ).hPadding(0.03.width),
              0.03.height.hSpace,
            ],
          ),
        ),
      ),
    );
  }
}
