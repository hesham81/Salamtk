import 'dart:developer';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/functions/otp_services.dart';
import 'package:salamtk/core/providers/app_providers/language_provider.dart';
import 'package:salamtk/core/utils/auth/phone_auth.dart';
import 'package:salamtk/modules/otp/page/otp.dart';
import '/core/services/snack_bar_services.dart';
import '/core/utils/auth/social_auth.dart';
import '/core/constant/shared_preference_key.dart';
import '/core/extensions/alignment.dart';
import '/core/services/local_storage/shared_preference.dart';
import '/modules/layout/patient/pages/patient_home/pages/patient_home.dart';
import '/modules/layout/doctor/pages/doctor_home.dart';
import '/core/utils/auth/login_auth.dart';
import '/modules/forget_password/pages/forget_password.dart';
import '/core/validations/validations.dart';
import '/modules/sign_up/pages/select_type/select_type.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_container.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_button.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/extensions/align.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var formKey = GlobalKey<FormState>();
  var phoneNumberController = TextEditingController();
  var formNumberKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loginWithEmail = true;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var provider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              AppAssets.logo,
            ),
            (loginWithEmail)
                ? Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextFormField(
                          hintText: local!.email,
                          suffixIcon: Icons.person_outline,
                          controller: usernameController,
                          validate: (value) {
                            return Validations.isEmailValid(
                                usernameController.text);
                          },
                        ),
                        0.02.height.hSpace,
                        CustomTextFormField(
                          hintText: local.password,
                          isPassword: true,
                          suffixIcon: Icons.lock_outline,
                          controller: passwordController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return local.pleasEnterYourPassword;
                            }
                            return null;
                          },
                        ),
                        CustomTextButton(
                          text: local.forgetPassword,
                          onPressed: () => slideLeftWidget(
                            newPage: ForgetPassword(),
                            context: context,
                          ),
                        ).alignBottomRight(),
                        CustomElevatedButton(
                          child: Text(
                            local.login,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              EasyLoading.show();
                              String? user = await LoginAuth.login(
                                email: usernameController.text,
                                password: passwordController.text,
                              );
                              if (user == null) {
                                EasyLoading.dismiss();
                                var snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    inMaterialBanner: true,
                                    color: Colors.red,
                                    title: 'Error',
                                    message: local.emailOrPasswordIncorrect,
                                    contentType: ContentType.failure,
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                              } else if (user == "doctor") {
                                EasyLoading.dismiss();
                                await SharedPreference.setString(
                                  SharedPreferenceKey.role,
                                  "doctor",
                                );
                                var snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    inMaterialBanner: true,
                                    color: AppColors.secondaryColor,
                                    title: 'Success',
                                    message:
                                        '${local.welcomeBack} ${usernameController.text}',
                                    contentType: ContentType.success,
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);

                                slideLeftWidget(
                                  newPage: DoctorHome(),
                                  context: context,
                                );
                              } else {
                                EasyLoading.dismiss();
                                var snackBar = SnackBar(
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    inMaterialBanner: true,
                                    color: AppColors.secondaryColor,
                                    title: 'Success',
                                    message:
                                        '${local.welcomeBack} ${usernameController.text}',
                                    contentType: ContentType.success,
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);

                                slideLeftWidget(
                                  newPage: PatientHome(),
                                  context: context,
                                );
                                await SharedPreference.setString(
                                  SharedPreferenceKey.role,
                                  "patient",
                                );
                              }
                            }
                          },
                        ).hPadding(0.07.width),
                      ],
                    ).hPadding(0.03.width),
                  )
                : Form(
                    key: formNumberKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextFormField(
                          hintText: local!.phoneNumber,
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
                        // TextButton(
                        //   onPressed: () {
                        //     setState(() {
                        //       loginWithEmail = !loginWithEmail;
                        //     });
                        //   },
                        //   child: Text(
                        //     local.loginWithEmail,
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .titleSmall!
                        //         .copyWith(
                        //           color: AppColors.secondaryColor,
                        //         ),
                        //   ),
                        // ).rightBottomWidget(),
                        // 0.1.height.hSpace,
                        CustomElevatedButton(
                          child: Text(
                            local.login,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () async {
                            if (formNumberKey.currentState!.validate()) {
                              EasyLoading.show();
                              var res = await PhoneNumberAuth.checkIfExist(
                                phoneNumber: phoneNumberController.text,
                              );
                              if (res != null) {
                                await OtpServices.sendOtp(
                                  phoneNumber: phoneNumberController.text,
                                  lan: "en",
                                  name: "",
                                );
                                slideLeftWidget(
                                  newPage: Otp(),
                                  context: context,
                                );
                              } else {
                                SnackBarServices.showErrorMessage(
                                  context,
                                  message: "Phone Number Is Not Exist",
                                );
                              }
                              EasyLoading.dismiss();
                            }
                          },
                        ).hPadding(0.07.width),
                      ],
                    ).hPadding(0.03.width),
                  ),
            0.02.height.hSpace,
            Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    EasyLoading.show();
                    await SocialAuthServices.loginWithGoogle(context);
                    EasyLoading.dismiss();
                  },
                  child: CustomContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.google,
                          height: 25,
                          width: 25,
                        ),
                        0.02.width.vSpace,
                        Text(
                          local.loginWithGoogle,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: AppColors.slateBlueColor,
                                  ),
                        )
                      ],
                    ),
                  ),
                ),
                0.02.height.hSpace,
                CustomTextButton(
                  text: local.dontHaveAnAccountJoinUs,
                  onPressed: () => slideLeftWidget(
                    newPage: SelectType(),
                    context: context,
                  ),
                )
              ],
            ).hPadding(0.03.width)
          ],
        ),
      ),
    );
  }
}
