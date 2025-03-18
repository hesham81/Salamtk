import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:route_transitions/route_transitions.dart';
import '/modules/sign_up/pages/select_type/select_type.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_container.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_button.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/extensions/align.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                AppAssets.logo,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    hintText: 'Username / email',
                    suffixIcon: Icons.person_outline,
                    controller: usernameController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username or email';
                      }
                      return null;
                    },
                  ),
                  0.02.height.hSpace,
                  CustomTextFormField(
                    hintText: 'Password',
                    isPassword: true,
                    suffixIcon: Icons.lock_outline,
                    controller: passwordController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  CustomTextButton(
                    text: "Forget Password",
                    onPressed: () {},
                  ).alignBottomRight(),
                  CustomElevatedButton(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                      }
                    },
                  ).hPadding(0.07.width),
                  0.02.height.hSpace,
                  CustomContainer(
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
                          "Login With Google",
                          style: TextStyle(
                            color: AppColors.slateBlueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  0.02.height.hSpace,
                  CustomTextButton(
                    text: "Don't Have An Account ? Join Us",
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
      ),
    );
  }
}
