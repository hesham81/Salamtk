import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/validations/validations.dart';
import '/core/widget/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/auth/sign_up_auth.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_button.dart';

class DoctorSignUp extends StatefulWidget {
  const DoctorSignUp({super.key});

  @override
  State<DoctorSignUp> createState() => _DoctorSignUpState();
}

class _DoctorSignUpState extends State<DoctorSignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String phoneNumber = "";
  List<String> specialists = [
    "heart",
    "general",
    "Lung",
    "Teeth",
    "Eye",
    "Surgery",
    "Nerves",
    "The interior"
  ];
  String? selectedSpecialist;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SafeArea(
                child: SvgPicture.asset(
                  AppAssets.signUpDoctorImage,
                ).center,
              ),
              0.02.height.hSpace,
              Column(
                children: [
                  CustomTextFormField(
                    hintText: "Name",
                    suffixIcon: Icons.person_outline,
                    validate: (value) => Validations.isNameValid(value ?? ""),
                    controller: nameController,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: "Description",
                    suffixIcon: Icons.edit,
                    minLine: 3,
                    maxLine: 3,
                    validate: (value) => Validations.isNameValid(value ?? ""),
                    controller: description,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: "Email",
                    suffixIcon: Icons.email_outlined,
                    validate: (value) => Validations.isEmailValid(value ?? ""),
                    controller: emailController,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: "Password",
                    isPassword: true,
                    validate: (value) =>
                        Validations.isPasswordValid(value ?? ""),
                    controller: passwordController,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: "Confirm Password",
                    isPassword: true,
                    validate: (value) => Validations.rePasswordValid(
                      passwordController.text,
                      value ?? "",
                    ),
                    controller: confirmPasswordController,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: local!.phonNumber,
                    controller: phoneNumberController,
                    suffixIcon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.number,
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
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: "Price",
                    controller: price,
                    keyboardType: TextInputType.number,
                    suffixIcon: Icons.attach_money_rounded,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Price";
                      }
                      return null;
                    },
                  ),
                  0.02.height.hSpace,
                  Text(
                    "Choose Your Specialist ",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.blackColor,
                        ),
                  ).alignTopLeft(),
                  0.02.height.hSpace,
                  DropdownMenu(
                    width: double.maxFinite,
                    onSelected: (value) {
                      selectedSpecialist = value;
                    },
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      iconColor: AppColors.secondaryColor,
                      prefixIconColor: AppColors.secondaryColor,
                      suffixIconColor: AppColors.secondaryColor,
                    ),
                    dropdownMenuEntries: [
                      for (var icon in specialists)
                        DropdownMenuEntry(
                          value: icon,
                          label: icon,
                        ),
                    ],
                  ),
                  0.02.height.hSpace,
                  CountryStateCityPicker(
                    country: country,
                    state: state,
                    city: city,
                    dialogColor: Colors.grey.shade200,
                    textFieldDecoration: InputDecoration(
                      fillColor: Colors.blueGrey.shade100,
                      filled: true,
                      suffixIcon: const Icon(Icons.arrow_downward_rounded),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  0.02.height.hSpace,
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate() &&
                            city.text != "" &&
                            state.text != "" &&
                            country.text != "" &&
                            selectedSpecialist != null) {
                          EasyLoading.show();
                          await SignUpAuth.doctorSignUp(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            phoneNumber: phoneNumber,
                            specialist: selectedSpecialist!,
                            price: double.tryParse(price.text) ?? 150,
                            country: country.text,
                            state: state.text,
                            city: city.text,
                            description: description.text,
                          ).then(
                            (value) {
                              if (value == null) {
                                EasyLoading.dismiss();
                                Navigator.pop(context);
                                EasyLoading.showSuccess(
                                  "Account Create Successfully",
                                );
                              } else {
                                EasyLoading.dismiss();
                                EasyLoading.showError(value);
                              }
                            },
                          );
                        }
                      },
                      child: Text(
                        "Sign Up",
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
                    text: "Have an account? Log in",
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ).hPadding(0.03.width),
            ],
          ),
        ),
      ),
    );
  }
}
