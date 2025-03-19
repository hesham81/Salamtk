import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '/core/utils/auth/sign_up_auth.dart';
import '/core/theme/app_colors.dart';
import '/core/validations/validations.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';

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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String phoneNumber = "";
  List<String> specialists = [
    'Dentist',
    'Cardiologist',
    'Gynecologist',
    'Ophthalmologist',
    'Neurologist',
    'Orthopedic Surgeon',
    'Dermatologist',
    'Pediatrician',
    'ENT Specialist',
    'Psychiatrist',
    'Endocrinologist',
    'Urologist',
    'Nephrologist',
    'Pulmonologist',
    'Gastroenterologist',
    'Rheumatologist',
    'Infectious Disease Specialist',
    'Oncologist',
    'Allergist/Immunologist',
    'Anesthesiologist',
  ];
  String? selectedSpecialist;

  @override
  Widget build(BuildContext context) {
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
                  IntlPhoneField(
                    showCursor: false,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff677294),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        phoneNumber = value.completeNumber;
                      });
                    },
                    initialCountryCode: 'EG',
                    invalidNumberMessage: "Please Enter A Valid Phone Number",
                  ),
                  0.02.height.hSpace,
                  Text(
                    "Choose Your Specialist ",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColors.blackColor,
                        ),
                  ).alignTopLeft(),
                  0.02.height.hSpace,
                  SizedBox(
                    width: double.maxFinite,
                    child: DropdownMenu(
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
                  ),
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
                            phoneNumber: phoneNumber,
                            isDoctor: true,
                            specialist:
                                selectedSpecialist ?? "No Specialist Selected",
                          ).then(
                            (value) {
                              if (value == null) {
                                Navigator.pop(context);
                                EasyLoading.dismiss();
                                EasyLoading.showSuccess(
                                  "Account Created Successfully",
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
                  )
                ],
              ).hPadding(0.03.width),
            ],
          ),
        ),
      ),
    );
  }
}
