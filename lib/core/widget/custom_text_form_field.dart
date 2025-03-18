import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

typedef ValidationFunction = String? Function(String? value);

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final double borderRadius;
  final IconData? suffixIcon;
  final bool isPassword;
  final ValidationFunction? validate;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.borderRadius = 20,
    this.suffixIcon,
    this.isPassword = false,
    this.validate,
    this.controller,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isVisible = false;

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
                    isVisible = !isVisible;
                  });
                },
                icon: Icon((isVisible)
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
              ),
        hintText: widget.hintText,
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
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff677294)),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
      style: theme.labelLarge!.copyWith(
        color: AppColors.slateBlueColor,
      ),
      obscureText: (widget.isPassword) ? isVisible : false,
    );
  }
}
