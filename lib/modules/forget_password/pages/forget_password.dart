import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:twseef/core/constant/app_assets.dart';
import 'package:twseef/core/extensions/dimensions.dart';
import 'package:twseef/core/extensions/extensions.dart';
import 'package:twseef/core/theme/app_colors.dart';
import 'package:twseef/core/utils/auth/login_auth.dart';
import 'package:twseef/core/validations/validations.dart';
import 'package:twseef/core/widget/custom_elevated_button.dart';
import 'package:twseef/core/widget/custom_text_form_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                hintText: "Email",
                controller: emailController,
                suffixIcon: Icons.email_outlined,
                validate: (value) {
                  return Validations.isEmailValid(value ?? "");
                },
              ).hPadding(0.03.width),
              0.1.height.hSpace,
              CustomElevatedButton(
                child: Text(
                  "Forget Password",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    EasyLoading.show();
                    await LoginAuth.forgetPassword(email: emailController.text)
                        .then(
                      (value) {
                        if (value == null) {
                          Navigator.pop(context);
                          EasyLoading.showSuccess("Email Sent Successfully");
                        } else {
                          EasyLoading.dismiss();
                          EasyLoading.showError(value);
                        }
                      },
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
