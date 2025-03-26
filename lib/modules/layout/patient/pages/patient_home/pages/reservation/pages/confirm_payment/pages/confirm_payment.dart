import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '/modules/layout/patient/pages/patient_home/pages/patient_home.dart';
import '/core/utils/reservations/reservation_collection.dart';
import '/models/reservations_models/reservation_model.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/widget/custom_container.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/patient/pages/patient_home/pages/reservation/pages/confirm_payment/widget/choose_payment_methods_widget.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmPayment extends StatefulWidget {
  const ConfirmPayment({super.key});

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
      bottomNavigationBar: Expanded(
        child: CustomElevatedButton(
          onPressed: () async {
            if (formKey.currentState!.validate() &&
                provider.getPaymentMethod != null) {
              EasyLoading.show();
              ReservationModel model = ReservationModel(
                patientPhoneNumber: phoneNumberController.text,
                reservationId: "",
                uid: userId,
                doctorId: provider.getDoctor!.uid!,
                date: provider.getSelectedDate!,
                slot: provider.getSelectedSlot!,
                price: provider.getDoctor!.price,
                paymentMethod: (provider.getPaymentMethod == local.bank)
                    ? "Bank"
                    : "Electronic Wallet",
                email: emailController.text,
                patientName: nameController.text,
              );
              await ReservationCollection.addReservation(model).then(
                (value) {
                  if (value) {
                    EasyLoading.dismiss();
                    EasyLoading.showSuccess("Doctor has been reserved");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientHome(),
                      ),
                      (route) => false,
                    );
                  } else {
                    EasyLoading.dismiss();
                    EasyLoading.showError("Error While Reserve Doctor");
                  }
                },
              );
            }
          },
          child: Text(
            local.pay,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
        ).allPadding(10),
      ),
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
                  ],
                ),
              ),
              0.03.height.hSpace,
              Text(
                local.name,
                style: Theme.of(context).textTheme.titleSmall!,
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: local.name,
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
                local.phonNumber,
                style: Theme.of(context).textTheme.titleSmall!,
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: local.phonNumber,
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
                isReadOnly: true,
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
              Text(
                local.choosePaymentMethod,
                style: Theme.of(context).textTheme.titleSmall!,
              ),
              0.01.height.hSpace,
              ChoosePaymentMethodsWidget(
                paymentMethod: local.electronicWallet,
              ),
              0.01.height.hSpace,
              ChoosePaymentMethodsWidget(
                paymentMethod: local.bank,
              ),
              0.05.height.hSpace,
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }
}
