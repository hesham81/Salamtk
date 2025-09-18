import 'package:flutter/material.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/theme/app_colors.dart';

class SelectedDoctorRateWidget extends StatelessWidget {
  final double rate;

  const SelectedDoctorRateWidget({
    super.key,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withAlpha(30),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: AppColors.secondaryColor,
          ),
          0.02.width.vSpace,
          Text(
            rate.toString(),
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: AppColors.secondaryColor,
                ),

          ),
        ],
      ).allPadding(5),
    );
  }
}
