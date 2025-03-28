import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

class CustomTextButton extends StatefulWidget {
  final String text;
  final Function() onPressed;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: AppColors.secondaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
