import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twseef/core/validations/validations.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_button.dart';
import '/core/widget/custom_text_form_field.dart';

class PatientSignUp extends StatefulWidget {
  const PatientSignUp({super.key});

  @override
  State<PatientSignUp> createState() => _PatientSignUpState();
}

class _PatientSignUpState extends State<PatientSignUp> {
  bool? _selectedValue;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            SafeArea(
              child: SvgPicture.asset(
                AppAssets.signUpDoctorImage,
              ).center,
            ),
            0.1.height.hSpace,
            Form(
              key: formKey,
              child: Column(
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
                    validate: (value) => Validations.isPasswordValid(value ?? ""),
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
                ],
              ).hPadding(0.03.width),
            ),
            Row(
              children: [
                Expanded(
                  child: Radio<bool>(
                    focusColor: AppColors.secondaryColor,
                    hoverColor: AppColors.secondaryColor,
                    fillColor: WidgetStatePropertyAll(AppColors.secondaryColor),
                    value: _selectedValue ?? false,
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    "I agree with the Terms of Service & Privacy Policy",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.slateBlueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            0.02.height.hSpace,
            SizedBox(
              width: double.maxFinite,
              child: CustomElevatedButton(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {},
              ),
            ).hPadding(0.05.width),
            0.02.height.hSpace,
            CustomTextButton(
              text: "Have an account? Log in",
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
