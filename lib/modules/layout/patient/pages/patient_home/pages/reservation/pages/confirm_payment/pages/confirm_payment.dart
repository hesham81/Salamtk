import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import '/modules/layout/patient/pages/patient_home/pages/reservation/pages/pay_with_electronic_wallet/pages/pay_with_electronic_wallet.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/widget/custom_container.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmPayment extends StatefulWidget {
  bool isSecondClinic;

   ConfirmPayment({
    super.key,
    this.isSecondClinic = false,
  });

  @override
  State<ConfirmPayment> createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? phoneNumber;
  String? selectedPaymentMethod;

  bool reserveToYourSelf = false;
  bool isConfirm = false;
  bool pay = false;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var provider = Provider.of<PatientProvider>(context);
    emailController.text = FirebaseAuth.instance.currentUser!.email!;
    String userId = FirebaseAuth.instance.currentUser!.uid;
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
          local!.pay,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
      ),
      bottomNavigationBar: CustomElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            provider.setReservationPhoneNumber(phoneNumberController.text);
            provider.setReservationName(nameController.text);
            provider.setReservationEmail(emailController.text);
            slideLeftWidget(
              newPage: PayWithElectronicWallet(
                isSecondClinic: widget.isSecondClinic,
              ),
              context: context,
            );
          }
        },
        child: Text(
          local.next,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
      ).allPadding(10),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              0.01.height.hSpace,
              CustomContainer(
                child: Column(
                  children: [
                    Text(
                      local.review,
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Text(
                          "${local.doctor} : ",
                          style: Theme.of(context).textTheme.titleSmall!,
                        ),
                        Spacer(),
                        Text(
                          provider.getDoctor!.name,
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
                          "${local.name} :",
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
                          "${local.date} :",
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
                          local.time,
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
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Text(
                          local.price,
                          style: Theme.of(context).textTheme.titleSmall!,
                        ),
                        Spacer(),
                        Text(
                          "${provider.getDoctor!.price} ${local.egp}",
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
              0.01.height.hSpace,
              SizedBox(
                width: double.maxFinite,
                child: CustomElevatedButton(
                  child: Text(
                    (!reserveToYourSelf)
                        ? local.reserveToYourSelf
                        : local.reserveToAnotherPatient,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: (reserveToYourSelf)
                              ? AppColors.primaryColor
                              : AppColors.secondaryColor,
                        ),
                  ),
                  borderColor: AppColors.secondaryColor,
                  onPressed: () {
                    setState(() {
                      reserveToYourSelf = !reserveToYourSelf;
                      if (reserveToYourSelf) {
                        nameController.text =
                            FirebaseAuth.instance.currentUser?.displayName ??
                                local.noName;
                      } else {
                        nameController.text = "";
                        phoneNumberController.text = "";
                      }
                    });
                  },
                  btnColor: (reserveToYourSelf)
                      ? AppColors.secondaryColor
                      : AppColors.primaryColor,
                ),
              ),
              0.02.height.hSpace,
              Text(
                local.name,
                style: Theme.of(context).textTheme.titleSmall!,
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: local.name,
                isReadOnly: (nameController.text == local.noName)
                    ? false
                    : reserveToYourSelf,
                controller: nameController,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return local.noName;
                  }
                  return null;
                },
                suffixIcon: Icons.person_outline,
              ),
              0.01.height.hSpace,
              Text(
                local.phoneNumber,
                style: Theme.of(context).textTheme.titleSmall!,
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                keyboardType: TextInputType.phone,
                hintText: local.phoneNumber,
                controller: phoneNumberController,
                suffixIcon: Icons.phone_android_outlined,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return local.emptyPhone;
                  }

                  final egyptPhoneRegex = RegExp(r'^0(10|11|12|15)\d{8}$');
                  if (!egyptPhoneRegex.hasMatch(value)) {
                    return local.phoneError;
                  }

                  return null;
                },
              ),
              0.02.height.hSpace,
              Text(
                local.email,
                style: Theme.of(context).textTheme.titleSmall!,
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                isReadOnly: (FirebaseAuth.instance.currentUser!.email != null)
                    ? true
                    : false,
                hintText: local.email,
                controller: emailController,
                suffixIcon: Icons.email_outlined,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return local.noEmail;
                  }
                  return null;
                },
              ),
              0.01.height.hSpace,
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }
}
