import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twseef/core/providers/patient_providers/patient_provider.dart';
import 'package:twseef/core/widget/custom_container.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/patient/pages/patient_home/pages/reservation/pages/confirm_payment/widget/choose_payment_methods_widget.dart';
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
    var provider = Provider.of<PatientProvider>(context);
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
            CustomContainer(
              child: Column(
                children: [
                  Text(
                    "Review",
                    style: Theme.of(context).textTheme.titleMedium!,
                  ),
                  0.01.height.hSpace,
                  Row(
                    children: [
                      Text(
                        "Doctor :",
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                      Spacer(),
                      Text(
                        provider.getDoctor!.name!,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.secondaryColor),
                      ),
                    ],
                  ),
                  0.01.height.hSpace,
                  Row(
                    children: [
                      Text(
                        "Name :",
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                      Spacer(),
                      Text(
                        FirebaseAuth.instance.currentUser!.displayName!,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.secondaryColor),
                      ),
                    ],
                  ),
                  0.01.height.hSpace,
                  Row(
                    children: [
                      Text(
                        "Date :",
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                      Spacer(),
                      Text(
                        "${provider.getSelectedDate!.day}/${provider.getSelectedDate!.month}/${provider.getSelectedDate!.year} ",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.secondaryColor),
                      ),
                    ],
                  ),
                  0.01.height.hSpace,
                  Row(
                    children: [
                      Text(
                        "Time : ",
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                      Spacer(),
                      Text(
                        provider.getSelectedSlot!,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.secondaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            0.03.height.hSpace,
            Text(
              "Name",
              style: Theme.of(context).textTheme.titleSmall!,
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: "Name",
              controller: nameController,
            ),
            0.01.height.hSpace,
            Text(
              "Phone Number",
              style: Theme.of(context).textTheme.titleSmall!,
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: "Phone Number ",
              controller: TextEditingController(),
            ),
            0.02.height.hSpace,
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
            0.05.height.hSpace,
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
