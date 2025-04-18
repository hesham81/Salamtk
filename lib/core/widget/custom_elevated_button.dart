import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

class CustomElevatedButton extends StatefulWidget {
  final Widget child;

  final Function()? onPressed;
  final Color? btnColor;
  final double borderRadius;
  final Color? borderColor;
  final EdgeInsets? padding;

  const CustomElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.btnColor,
    this.borderRadius = 12,
    this.borderColor,
    this.padding,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        side: (widget.borderColor != null)
            ? BorderSide(
                color: widget.borderColor ?? AppColors.secondaryColor, width: 2)
            : null,
        backgroundColor: widget.btnColor ?? AppColors.secondaryColor,
        padding: widget.padding ?? EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
      child: widget.child,
    );
  }
}
