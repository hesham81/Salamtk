import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

typedef ValidationFunction = String? Function(String? value);

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final double borderRadius;
  final IconData? suffixIcon;
  final bool isPassword;
  final ValidationFunction? validate;
  final TextEditingController controller;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.borderRadius = 20,
    this.suffixIcon,
    this.isPassword = false,
    this.validate,
    required this.controller,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isVisible = false; // Controls password visibility

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return TextFormField(
      validator: widget.validate,
      controller: widget.controller,
      cursorColor: AppColors.secondaryColor,
      decoration: InputDecoration(
        suffixIcon: (widget.isPassword == false)
            ? (widget.suffixIcon == null)
            ? null
            : Icon(widget.suffixIcon)
            : IconButton(
          onPressed: () {
            setState(() {
              isVisible = !isVisible; // Toggle password visibility
            });
          },
          icon: Icon(
            (isVisible)
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),
        hintText: widget.hintText, // Use the provided hintText
        prefixIconColor: AppColors.slateBlueColor,
        suffixIconColor: AppColors.slateBlueColor,
        focusColor: AppColors.slateBlueColor,
        iconColor: AppColors.slateBlueColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff677294),
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff677294)),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff677294)),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
      style: theme.labelLarge?.copyWith(
        color: AppColors.slateBlueColor,
      ) ??
          TextStyle(
            fontSize: 16,
            color: AppColors.slateBlueColor,
          ), // Fallback style if labelLarge is null
      obscureText: (widget.isPassword) ? !isVisible : false, // Fix obscureText logic
    );
  }
}