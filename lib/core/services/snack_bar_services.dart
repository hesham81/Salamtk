import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

abstract class SnackBarServices {
  static void showSuccessMessage(
    BuildContext context, {
    required String message,
    String? title,
    Color? color,
  }) {
    var snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        inMaterialBanner: true,
        color: color ?? AppColors.secondaryColor,
        title: title ?? 'Success',
        message: message,
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showErrorMessage(
    BuildContext context, {
    required String message,
    String? title,
    Color? color,
  }) {
    var snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        inMaterialBanner: true,
        color: color ?? Colors.red,
        title: title ?? 'Error',
        message: message,
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
