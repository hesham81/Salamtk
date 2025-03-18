import 'package:flutter/material.dart';
import '/core/route/route_names.dart';
import '/modules/sign_in/pages/sign_in.dart';
import '/modules/splash_screen/pages/splash_screen.dart';

abstract class OnGenerateRoute {
  static Route route(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.signIn:
        return MaterialPageRoute(
          builder: (context) => SignIn(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
    }
  }
}
