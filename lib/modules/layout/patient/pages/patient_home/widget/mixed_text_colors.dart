import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_container.dart';

class MixedTextColors extends StatelessWidget {
  final String title;

  final String value;

  const MixedTextColors({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return CustomContainer(
      child: Row(
        children: [
          Text(
            "$title : ",
            style: theme.textTheme.titleSmall,
          ),
          0.01.width.vSpace,
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.titleSmall!
                  .copyWith(color: AppColors.secondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
