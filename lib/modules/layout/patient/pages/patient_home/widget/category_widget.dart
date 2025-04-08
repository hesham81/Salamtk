import 'package:flutter/material.dart';
import 'package:salamtk/core/extensions/align.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/categoriezed_doctors/pages/categorized_doctors.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class CategoryWidget extends StatelessWidget {
  final IconData? icon;

  final Widget? child;

  final Color? color;

  final String text;

  const CategoryWidget.icon({
    super.key,
    required this.icon,
    this.child,
    this.color,
    required this.text,
  });

  const CategoryWidget.child({
    super.key,
    required this.child,
    this.icon,
    this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategorizedDoctors(),
              settings: RouteSettings(arguments: text), // Pass the arguments here
            ),
          ),
          child: Container(
            height: 0.1.height,
            width: 0.2.width,
            decoration: BoxDecoration(
              color: color ?? Colors.red.withAlpha(80),
              borderRadius: BorderRadius.circular(25),
            ),
            child: child ??
                Icon(
                  icon,
                  color: AppColors.primaryColor,
                ),
          ),
        ),
        0.01.height.hSpace,
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ).center,
      ],
    );
  }
}
