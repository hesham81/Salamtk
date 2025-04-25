import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/services/snack_bar_services.dart';
import 'package:salamtk/modules/sign_up/pages/doctor_sign_up/additional_sign_up_doctor_data.dart';
import '/core/providers/sign_up_providers/sign_up_providers.dart';
import '/core/widget/custom_container.dart';
import '/core/widget/select_map.dart';
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
  List<String> specialists = [
    "Obstetrics",
    "Teeth",
    "Urology",
    "Lung",
    "Pediatrics",
    "Psychiatry",
    "Ear, Nose & Throat (ENT)",
    "Dermatology",
    "Orthopedics",
    "Eye",
    "Heart",
    "Nutritionist",
    "Family Medicine & Allergy",
    "Orthopedic",
    "Gastroenterology",
    "Internal Medicine",
    "Surgery",
    "Acupuncture",
    "Vascular Surgery",
    "Nephrology",
    "Radiology",
    "Endocrinology",
    "Genetics",
    "Speech Therapy",
    "Pain Management",
    "Cosmetic Surgery"
  ];
  String? selectedSpecialist;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var provider = Provider.of<SignUpProviders>(context);
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
                    hintText: local!.name,
                    suffixIcon: Icons.person_outline,
                    validate: (value) => Validations.isNameValid(value ?? ""),
                    controller: nameController,
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: local.description,
                    suffixIcon: Icons.edit,
                    minLine: 3,
                    maxLine: 3,
                    validate: (value) => Validations.isNameValid(value ?? ""),
                    controller: description,
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
                  CustomTextFormField(
                    hintText: local!.phoneNumber,
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
                    hintText: local.price,
                    controller: price,
                    keyboardType: TextInputType.number,
                    suffixIcon: Icons.attach_money_rounded,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Price";
                      }
                      return null;
                    },
                  ),
                  0.02.height.hSpace,
                  Text(
                    local.chooseYourSpecialist,
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
                  GestureDetector(
                    onTap: () => slideLeftWidget(
                      newPage: SelectMap(),
                      context: context,
                    ),
                    child: CustomContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.map_outlined,
                            color: AppColors.secondaryColor,
                          ),
                          Text(
                            local.selectClinicLocation,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: AppColors.blackColor,
                                ),
                          ),
                          0.01.width.vSpace,
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: AppColors.secondaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  0.02.height.hSpace,
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate() &&
                            selectedSpecialist != null) {
                          if (provider.marker == null) {
                            SnackBarServices.showErrorMessage(
                              context,
                              message: local.selectClinicLocation,
                            );
                            return;
                          }
                          provider.setDoctorData(
                            name: nameController.text,
                            description: description.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phoneNumber: phoneNumberController.text,
                            price: double.tryParse(price.text) ?? 0.0,
                            specialist: selectedSpecialist!,
                          );
                          slideLeftWidget(
                            newPage: AdditionalSignUpDoctorData(),
                            context: context,
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
