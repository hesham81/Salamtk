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
  final bool isSignUp;

  final bool isSignIn;

  final Function()? onCorrect;

  const Otp({
    super.key,
    this.route,
    this.isSignIn = true,
    this.isSignUp = false,
    this.onCorrect,
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

  // _signInMethod({
  //   required String phoneNumber,
  //   required String hashedPassword ,
  //   required String
  // }) {}

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
                  (this.widget.onCorrect == null)
                      ? slideLeftWidget(
                          newPage: widget.route ?? PatientHome(),
                          context: context,
                        )
                      : this.widget.onCorrect!();
                }
              },
              keyboardType: TextInputType.number,
              enabled: true,
              numberOfFields: 4,
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
