import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_container.dart';

class MixedTextColors extends StatelessWidget {
  final String title;

  final String? value;

  final Color? valueColor;

  final Widget? child;

  const MixedTextColors({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.child = null,
  });

  const MixedTextColors.widget(
      {super.key,
      required this.title,
      this.value = null,
      this.valueColor,
      required this.child});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return CustomContainer(
      child: Row(
        children: [
          Text(
            (child == null) ? "$title : " : title,
            style: theme.textTheme.titleSmall,
          ),
          (child == null) ? 0.01.width.vSpace : Spacer(),
          (child != null)
              ? child!
              : Expanded(
                  child: Text(
                    value!,
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: valueColor ?? AppColors.secondaryColor,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
