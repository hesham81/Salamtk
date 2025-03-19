import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_container.dart';

class ChoosePaymentMethodsWidget extends StatelessWidget {
  final String paymentMethod;

  const ChoosePaymentMethodsWidget({
    super.key,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PatientProvider>(context);

    return CustomContainer(
      child: Row(
        children: [
          Radio<String>(
            value: paymentMethod,
            groupValue: provider.getPaymentMethod,
            fillColor: MaterialStatePropertyAll(AppColors.secondaryColor),
            activeColor: AppColors.secondaryColor,
            onChanged: (value) {
              provider.setSelectedPaymentMethod(value!);
            },
          ),
          Spacer(),
          Text(
            paymentMethod,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}