import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

abstract class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.primaryColor,
    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: AppColors.blackColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
