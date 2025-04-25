import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
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
                    controller: emailController,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: local.phoneNumber,
                    controller: phoneNumberController,
                    suffixIcon: Icons.phone_android_outlined,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return local.emptyPhone;
                      }

                      final egyptPhoneRegex =
                      RegExp(r'^0(10|11|12|15)\d{8}$');
                      if (!egyptPhoneRegex.hasMatch(value)) {
                        return local.phoneError;
                      }

                      return null;
                    },
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
                            Navigator.pop(context);
                            EasyLoading.dismiss();
                            var snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                inMaterialBanner: true,
                                color: AppColors.secondaryColor,
                                title: 'Success',
                                message: 'Account Created Successfully',
                                contentType: ContentType.success,
                              ),
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);

                          } else {
                            EasyLoading.dismiss();
                            var snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                inMaterialBanner: true,
                                color: AppColors.secondaryColor,
                                title: 'Error',
                                message: value,
                                contentType: ContentType.failure,
                              ),
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }
                        },
                      );
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
