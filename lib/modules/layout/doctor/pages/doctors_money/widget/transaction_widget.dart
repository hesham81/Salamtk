import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:route_transitions/route_transitions.dart';
import '/modules/layout/doctor/pages/doctors_money/pages/check_transactions_status.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_container.dart';
import '/models/money/money_request_model.dart';

class TransactionWidget extends StatelessWidget {
  final MoneyRequestModel model;

  const TransactionWidget({
    super.key,
    required this.model,
  });

  _difference() {
    var difference = DateTime.now().difference(model.date).inDays;
    return (difference > 7)
        ? "${difference ~/ 7} Week"
        : (difference < 0)
            ? difference * -1
            : (difference == 0)
                ? "Today"
                : "${difference} ${difference == 1 ? "Day" : "Days"}";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (model.status == "Completed" || model.status == "Cancelled")
          ? () => slideLeftWidget(
              newPage: CheckTransactionsStatus(
                model: model,
              ),
              context: context)
          : null,
      child: CustomContainer(
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/money.svg",
            ),
            0.01.width.vSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? "No Name",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.blackColor,
                      ),
                ),
                0.01.height.hSpace,
                Text(
                  "${_difference()}",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: AppColors.slateBlueColor,
                      ),
                )
              ],
            ),
            Spacer(),
            Text(
              "${model.amount.toStringAsFixed(1)} EGP",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: (model.status == "Pending")
                        ? Colors.amber
                        : (model.status == "Completed")
                            ? Colors.green
                            : Colors.red,
                  ),
            ),
          ],
        ).hPadding(0.02.width),
      ),
    );
  }
}
