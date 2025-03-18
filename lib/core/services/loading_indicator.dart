import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/core/theme/app_colors.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.secondaryColor
    ..backgroundColor = AppColors.primaryColor
    ..indicatorColor = AppColors.primaryColor
    ..textColor = AppColors.secondaryColor
    ..maskColor = AppColors.primaryColor
    ..userInteractions = true
    ..dismissOnTap = false;
}
