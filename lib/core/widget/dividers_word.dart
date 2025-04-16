import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class DividersWord extends StatelessWidget {
  final String text;

  const DividersWord({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: AppColors.blackColor,
            indent: 12,
            endIndent: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            thickness: 1,
            color: AppColors.blackColor,
            endIndent: 12,
            indent: 2,
          ),
        ),
      ],
    );
  }
}
