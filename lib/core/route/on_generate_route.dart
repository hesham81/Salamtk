import 'package:flutter/material.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/reservation/pages/reservation.dart';
import 'package:salamtk/modules/layout/patient/pages/patient_home/pages/reservation/revision_page/page/revision_page.dart';
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
      case RouteNames.revisionPage:
        return MaterialPageRoute(
          builder: (context) => Reservation(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
    }
  }
}
