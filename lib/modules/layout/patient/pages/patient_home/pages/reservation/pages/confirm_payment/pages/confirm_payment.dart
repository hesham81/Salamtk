import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:twseef/core/widget/custom_container.dart';
import 'package:twseef/core/widget/custom_elevated_button.dart';
import 'package:twseef/modules/layout/patient/pages/patient_home/pages/reservation/pages/confirm_payment/widget/choose_payment_methods_widget.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/theme/app_colors.dart';

class ConfirmPayment extends StatefulWidget {
  const ConfirmPayment({super.key});

  @override
  State<ConfirmPayment> createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? phoneNumber;
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryColor,
          ),
        ),
        title: Text(
          "Pay",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
      ),
      bottomNavigationBar: Expanded(
        child: CustomElevatedButton(
          onPressed: () {},
          child: Text(
            "Pay",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
        ).allPadding(10),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            0.01.height.hSpace,
            Text(
              "Name",
              style: Theme.of(context).textTheme.titleSmall!,
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: "Name",
              controller: nameController,
            ),
            0.02.height.hSpace,
            IntlPhoneField(
              showCursor: false,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff677294),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff677294),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff677294),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusColor: Color(0xff677294),
              ),
              onChanged: (value) {
                setState(() {
                  phoneNumber = value.completeNumber;
                });
              },
              initialCountryCode: 'EG',
              invalidNumberMessage: "Please Enter A Valid Phone Number",
            ),
            Text(
              "Email",
              style: Theme.of(context).textTheme.titleSmall!,
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: "Email",
              controller: emailController,
            ),
            0.01.height.hSpace,
            Text(
              "Choose Payment Method",
              style: Theme.of(context).textTheme.titleSmall!,
            ),
            0.01.height.hSpace,
            ChoosePaymentMethodsWidget(
              paymentMethod: 'Electronic Wallet',
            ),
            0.01.height.hSpace,
            ChoosePaymentMethodsWidget(
              paymentMethod: 'Bank',
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
