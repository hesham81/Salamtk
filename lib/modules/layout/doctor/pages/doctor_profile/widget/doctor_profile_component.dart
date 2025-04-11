import 'package:flutter/material.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/theme/app_colors.dart';
import 'package:salamtk/core/widget/custom_container.dart';

class DoctorProfileComponent extends StatelessWidget {
  final IconData icon;

  final String content;

  const DoctorProfileComponent({
    super.key,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.secondaryColor,
          ),
          0.03.width.vSpace,
          Text(
            content,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.blackColor ,
                ),
          ),
        ],
      ),
    );
  }
}
