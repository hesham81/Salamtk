import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_container.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_button.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/extensions/align.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.02.height.hSpace,
            SafeArea(
              child: SvgPicture.asset(AppAssets.logo),
            ),
            0.04.height.hSpace,
            Text(
              "Welcome Back",
              style: theme.titleMedium,
            ).center,
            0.1.height.hSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFormField(
                  hintText: 'Username / email',
                  suffixIcon: Icons.person_outline,
                ),
                0.02.height.hSpace,
                CustomTextFormField(
                  hintText: 'Password',
                  isPassword: true,
                ),
                0.02.height.hSpace,
                CustomElevatedButton(
                  child: Text("Login",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                  onPressed: () {},
                ).hPadding(0.07.width),
                // 0.02.height.hSpace,
                CustomTextButton(
                  text: "Forget Password",
                  onPressed: () {},
                ),
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
                  onPressed: () {},
                )
              ],
            ).hPadding(0.03.width)
          ],
        ),
      ),
    );
  }
}
