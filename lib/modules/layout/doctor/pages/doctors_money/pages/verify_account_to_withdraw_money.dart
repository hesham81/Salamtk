import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import '/core/utils/doctors/requests_collections.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/services/otp_services.dart';
import '/core/services/snack_bar_services.dart';
import '/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyAccountToWithdrawMoney extends StatefulWidget {
  final double amount;
  final String phoneNumber;

  const VerifyAccountToWithdrawMoney({
    super.key,
    required this.amount,
    required this.phoneNumber,
  });

  @override
  State<VerifyAccountToWithdrawMoney> createState() =>
      _VerifyAccountToWithdrawMoneyState();
}

class _VerifyAccountToWithdrawMoneyState
    extends State<VerifyAccountToWithdrawMoney> {
  @override
  Widget build(BuildContext context) {
  var local = AppLocalizations.of(context);
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
                bool? response =  OtpServices.verifyOtp(value);
                if (response == null) {
                  SnackBarServices.showErrorMessage(
                    context,
                    message: "OTP Expired ",
                  );
                } else if (response) {
                  EasyLoading.show();
                  await RequestsCollections.requestAmount(
                    amount: widget.amount,
                    phoneNumber: widget.phoneNumber,
                  );
                  EasyLoading.dismiss();
                  SnackBarServices.showSuccessMessage(
                    context,
                    message: "Request Sent Successfully",
                  );
                  Navigator.pop(context);
                } else {
                  SnackBarServices.showErrorMessage(
                    context,
                    message: "OTP Verification Failed",
                  );
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
              onPressed: () async {
                EasyLoading.show();
                await OtpServices.sendOtp();
                EasyLoading.dismiss();
              },
              backgroundColor: AppColors.secondaryColor,
              textColor: AppColors.primaryColor,
              text: Text(
                local!.resendCode,
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
