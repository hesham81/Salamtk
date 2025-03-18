import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

class CustomElevatedButton extends StatefulWidget {
  final Widget child;

  final Function() onPressed;
  final Color? btnColor;
  final double borderRadius;

  const CustomElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.btnColor,
     this.borderRadius = 12,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.btnColor ?? AppColors.secondaryColor,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
      child: widget.child,
    );
  }
}
