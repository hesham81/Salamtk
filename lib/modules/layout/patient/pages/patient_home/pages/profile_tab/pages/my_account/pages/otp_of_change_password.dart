import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/extensions/dimensions.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/widget/custom_elevated_button.dart';
import 'package:salamtk/core/widget/custom_text_form_field.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/profile_tab/pages/my_account/pages/change_password.dart';
import 'package:salamtk/modules/otp/page/otp.dart';

import '../../../../../../../../../../core/functions/otp_services.dart';
import '../../../../../../../../../../core/theme/app_colors.dart';

class OtpOfChangePassword extends StatefulWidget {
  const OtpOfChangePassword({super.key});

  @override
  State<OtpOfChangePassword> createState() => _OtpOfChangePasswordState();
}

class _OtpOfChangePasswordState extends State<OtpOfChangePassword> {
  TextEditingController controller = TextEditingController();
  var _formKey = GlobalKey<FormState>();

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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/icons/5f9fb7ad7b9d9d9743e857f23987148e.jpg",
            ),
            0.03.height.hSpace,
            Text(
              local.phoneNumber,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(),
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: local.phoneNumber,
              controller: controller,
              borderRadius: 10,
              validate: (value) {
                if (value == null || value.isEmpty) return local.emptyPhone;

                // Remove all non-digits
                String cleaned = value.replaceAll(RegExp(r'\D'), '');

                // If starts with +20, replace with 0
                if (cleaned.startsWith('20') && cleaned.length == 12) {
                  cleaned = '0' + cleaned.substring(2);
                }

                final egyptPhoneRegex = RegExp(r'^0(10|11|12|15)\d{8}$');
                if (!egyptPhoneRegex.hasMatch(cleaned)) {
                  return local.phoneError;
                }
                return null;
              },
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
                  if (!_formKey.currentState!.validate()) return;
                  EasyLoading.show();
                  await OtpServices.sendOtp(
                    phoneNumber: controller.text,
                    lang: 'ar',
                    name: FirebaseAuth.instance.currentUser?.displayName ??
                        local.noName,
                  );
                  EasyLoading.dismiss();
                  slideLeftWidget(
                    newPage: Otp(
                      onCorrect: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePassword(),
                            ),
                          );
                      },
                    ),
                    context: context,
                  );
                }).allPadding(10),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
