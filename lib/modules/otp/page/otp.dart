import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:salamtk/core/utils/auth/phone_auth.dart';
import '/core/services/local_storage/shared_preference.dart';
import '/modules/layout/patient/pages/patient_home/pages/patient_home.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../core/theme/app_colors.dart';

class Otp extends StatefulWidget {
  final Widget? route;

  const Otp({
    super.key,
    this.route,
  });

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  Future<void> _getOtpValue() async {
    otp = await SharedPreference.getString("otp") ?? "";
    setState(() {});
  }

  String otp = "";

  _createAuth() async {
    await SharedPreference.remove("otp");
    var data = await PhoneNumberAuth.getToken(
      phoneNumber: "01027002208",
    );
    await FirebaseAuth.instance.signInWithPhoneNumber(
      "01027002208",
    );
  }

  @override
  void initState() {
    Future.wait([
      _getOtpValue(),
    ]);
    super.initState();
  }

  _getAutoFill() async {
    var response = await SmsAutoFill();
    response.code.listen(
      (event) {
        log("Auto Fill is $event");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _getAutoFill();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/icons/otp.jpg",
            ),
            OtpTextField(
              onSubmit: (value) async {
                if (value == otp) {
                  await _createAuth();
                  slideLeftWidget(
                    newPage: widget.route ?? PatientHome(),
                    context: context,
                  );
                }
              },
              keyboardType: TextInputType.number,
              enabled: true,
              numberOfFields: 6,
              cursorColor: AppColors.slateBlueColor,
              focusedBorderColor: AppColors.slateBlueColor,
              enabledBorderColor: AppColors.secondaryColor,
            )
          ],
        ),
      ),
    );
  }
}
