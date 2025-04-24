import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import '/core/services/otp_services.dart';
import '/modules/layout/doctor/pages/doctors_money/pages/verify_account_to_withdraw_money.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoneyRequestModelSheet extends StatefulWidget {
  final double totalAmount;
  final String phoneNumber;

  const MoneyRequestModelSheet({
    super.key,
    required this.totalAmount,
    required this.phoneNumber,
  });

  @override
  State<MoneyRequestModelSheet> createState() => _MoneyRequestModelSheetState();
}

class _MoneyRequestModelSheetState extends State<MoneyRequestModelSheet> {
  bool isSelected = true;

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  double withDrawAmount = 0;
  double afterWithDrawAmount = 0;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            0.01.height.hSpace,
            Text(
              local!.moneyRequest,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.slateBlueColor,
                  ),
            ).center,
            0.01.height.hSpace,
            Divider(),
            CustomTextFormField(
              hintText: local.amount,
              controller: amountController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  afterWithDrawAmount =
                      widget.totalAmount - double.parse(value!);
                });
                return null;
              },
              validate: (value) {
                if (value == null ||
                    value.isEmpty ||
                    double.parse(value) > widget.totalAmount) {
                  return "Your Amount Not Enough";
                } else if (double.parse(value) < 50) {
                  return "Less Than 100";
                } else {
                  return null;
                }
              },
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: (!isSelected)
                  ? FirebaseAuth.instance.currentUser?.phoneNumber ??
                      "No Phone Number"
                  : "Phone Number",
              controller: phoneNumberController,
              isReadOnly: (isSelected) ? false : true,
              keyboardType: TextInputType.phone,
              suffixIcon: Icons.phone,
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return local!.emptyPhone;
                }

                final egyptPhoneRegex = RegExp(r'^0(10|11|12|15)\d{8}$');
                if (!egyptPhoneRegex.hasMatch(value)) {
                  return local!.phoneError;
                }

                return null;
              },
            ),
            0.01.height.hSpace,
            AnimatedButton(
              borderRadius: 25,
              selectedText: local.yourPhoneNumber,
              text: local.anotherPhoneNumber,
              textStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColors.primaryColor,
                  ),
              backgroundColor: AppColors.secondaryColor,
              isReverse: true,
              isSelected: isSelected,
              onPress: () {
                if (isSelected) {
                  phoneNumberController.text = widget.phoneNumber;
                } else {
                  phoneNumberController.clear();
                }
                setState(() {
                  isSelected = !isSelected;
                });
              },
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            Divider().hPadding(0.2.width),
            Row(
              children: [
                Text(
                  "${local.totalAmount}: ",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.blackColor,
                      ),
                ),
                Text(
                  "${widget.totalAmount.toStringAsFixed(1)} ${local.egp}",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.slateBlueColor,
                      ),
                ),
              ],
            ),
            0.02.height.hSpace,
            Row(
              children: [
                Text(
                  "${local.afterWithdrawAmount}: ",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.blackColor,
                      ),
                ),
                Text(
                  "${(amountController.text.isEmpty) ? widget.totalAmount.toStringAsFixed(1) : afterWithDrawAmount.toStringAsFixed(1)} ${local.egp}",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.slateBlueColor,
                      ),
                ),
              ],
            ),
            0.01.height.hSpace,
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    child: Text(
                      local.request,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.primaryColor,
                          ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        OtpServices.sendOtp();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyAccountToWithdrawMoney(
                              amount: double.parse(
                                amountController.text,
                              ),
                              phoneNumber: phoneNumberController.text,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                0.01.width.vSpace,
                Expanded(
                  child: CustomElevatedButton(
                    child: Text(
                      local.cancel,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.primaryColor,
                          ),
                    ),
                    btnColor: Colors.red,
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
            0.01.height.hSpace,
          ],
        ).allPadding(5),
      ),
    );
  }
}
