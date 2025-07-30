import 'package:flutter/material.dart';
import 'package:salamtk/core/extensions/extensions.dart';
import 'package:salamtk/core/theme/app_colors.dart';

class IconRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.blackColor.withAlpha(80),
        ),
        0.01.width.vSpace,
        Text(
          text,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColors.blackColor.withAlpha(80),
              ),
        ),
      ],
    );
  }
}
