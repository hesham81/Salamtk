import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

abstract class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.primaryColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
      backgroundColor: AppColors.secondaryColor,
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: AppColors.blackColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
