import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/functions/otp_services.dart';
import 'package:salamtk/core/services/local_storage/shared_preference.dart';
import 'package:salamtk/core/services/snack_bar_services.dart';
import 'package:salamtk/core/utils/auth/phone_auth.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/patient_home.dart';
import 'package:salamtk/modules/otp/page/otp.dart';
import '/core/utils/auth/sign_up_auth.dart';
import '/core/validations/validations.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_button.dart';
import '/core/widget/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientSignUp extends StatefulWidget {
  const PatientSignUp({super.key});

  @override
  State<PatientSignUp> createState() => _PatientSignUpState();
}

class _PatientSignUpState extends State<PatientSignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              0.01.height.hSpace,
              SafeArea(
                child: SvgPicture.asset(
                  AppAssets.signUpPatientImage,
                ).center,
              ),
              0.1.height.hSpace,
              Column(
                children: [
                  CustomTextFormField(
                    hintText: local!.name,
                    suffixIcon: Icons.person_outline,
                    validate: (value) => Validations.isNameValid(value ?? ""),
                    controller: nameController,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: local.email,
                    suffixIcon: Icons.email_outlined,
                    validate: (value) => Validations.isEmailValid(value ?? ""),
                    controller: emailController,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: local.password,
                    isPassword: true,
                    validate: (value) =>
                        Validations.isPasswordValid(value ?? ""),
                    controller: passwordController,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: local.confirmPassword,
                    isPassword: true,
                    validate: (value) => Validations.rePasswordValid(
                      passwordController.text,
                      value ?? "",
                    ),
                    controller: confirmPasswordController,
                  ),
                  0.02.height.hSpace,
                  0.02.height.hSpace,
                ],
              ).hPadding(0.03.width),
              0.02.height.hSpace,
              SizedBox(
                width: double.maxFinite,
                child: CustomElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      EasyLoading.show();
                      await SignUpAuth.signUp(
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                      ).then(
                        (value) {
                          if (value == null) {
                            slideLeftWidget(
                              newPage: PatientHome(),
                              context: context,
                            );
                          } else {
                            SnackBarServices.showErrorMessage(
                              context,
                              message: value,
                            );
                          }
                        },
                      );

                      EasyLoading.dismiss();
                    }
                  },
                  child: Text(
                    local.signUp,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ).hPadding(0.05.width),
              0.02.height.hSpace,
              CustomTextButton(
                text: local.haveAnAccountLogin,
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
