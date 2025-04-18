import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/services/otp_services.dart';
import '/core/services/snack_bar_services.dart';
import '/core/theme/app_colors.dart';

class VerifyAccountToWithdrawMoney extends StatefulWidget {
  const VerifyAccountToWithdrawMoney({super.key});

  @override
  State<VerifyAccountToWithdrawMoney> createState() =>
      _VerifyAccountToWithdrawMoneyState();
}

class _VerifyAccountToWithdrawMoneyState
    extends State<VerifyAccountToWithdrawMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/icons/otp.jpg",
            ),
            Text(
              "Otp Code Sent to ${OtpServices.email} Check Your Email And Enter One Time Password (OTP) To Confirm Withdraw Money",
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ).center,
            0.03.height.hSpace,
            OtpTextField(
              onSubmit: (value) async {
                bool? response = await OtpServices.verifyOtp(value);
                if (response == null) {
                  SnackBarServices.showErrorMessage(context,
                      message: "OTP Expired New Code Sent");
                } else if (response) {
                  SnackBarServices.showSuccessMessage(context,
                      message: "OTP Verified Successfully");
                  Navigator.pop(context);
                } else {
                  SnackBarServices.showErrorMessage(context,
                      message: "OTP Verification Failed");
                  Navigator.pop(context);
                }
              },
              keyboardType: TextInputType.number,
              enabled: true,
              numberOfFields: 6,
              cursorColor: AppColors.slateBlueColor,
              focusedBorderColor: AppColors.slateBlueColor,
              enabledBorderColor: AppColors.secondaryColor,
            ),
            0.03.height.hSpace,
            OtpTimerButton(
              onPressed: () async{
                EasyLoading.show();
                await OtpServices.sendOtp();
                EasyLoading.dismiss();
              },
              backgroundColor: AppColors.secondaryColor,
              textColor: AppColors.primaryColor,
              text: Text(
                "Resend Code",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.primaryColor,
                ),
              ),
              duration: 30,
            ),
          ],
        ),
      ),
    );
  }
}
