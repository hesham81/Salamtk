import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:salamtk/core/extensions/dimensions.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/functions/security_functions.dart';
import 'package:salamtk/core/utils/auth/auth_collections.dart';
import 'package:salamtk/core/validations/validations.dart';
import 'package:salamtk/core/widget/custom_text_form_field.dart';

import '../../../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../../../core/widget/custom_elevated_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local!.changePassword,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            0.03.width.hSpace,
            Text(
              local.password,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: "",
              controller: passwordController,
              isPassword: true,
              borderRadius: 10,
              validate: (value) {
                if (value!.isEmpty) {
                  return local.error;
                }
                return null;
              },
            ),
            0.02.height.hSpace,
            Text(
              local.confirmPassword,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            0.02.height.hSpace,
            CustomTextFormField(
              hintText: "",
              controller: confirmPasswordController,
              isPassword: true,
              borderRadius: 10,
              validate: (value) => Validations.rePasswordValid(
                passwordController.text,
                value ?? "",
              ),
            ),
            Spacer(),
            CustomElevatedButton(
              child: Text(
                local.done,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.primaryColor,
                    ),
              ),
              onPressed: () async {
                if(!formKey.currentState!.validate()) return;
                  EasyLoading.show();
                  await AuthCollections.changePassword(
                    SecurityServices.encryptPassword(
                      password: passwordController.text,
                    ),
                  );
                  Navigator.pop(context);
                  EasyLoading.dismiss();
              },
            ).allPadding(10),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
