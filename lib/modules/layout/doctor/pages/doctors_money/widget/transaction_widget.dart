import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/theme/app_colors.dart';
import 'package:salamtk/core/widget/custom_container.dart';

class TransactionWidget extends StatelessWidget {
  final String name;

  final double price;

  final Color color;

  final DateTime date;

  const TransactionWidget({
    super.key,
    required this.name,
    required this.price,
    this.color = Colors.green,
    required this.date,
  });

  _difference() {
    var difference = DateTime.now().difference(date).inDays;
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
    return CustomContainer(
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
                name,
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
            "${price.toStringAsFixed(1)} EGP",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: color,
                ),
          ),
        ],
      ).hPadding(0.02.width),
    );
  }
}
