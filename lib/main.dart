import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/core/services/loading_indicator.dart';
import '/core/route/on_generate_route.dart';
import '/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  configLoading();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      navigatorKey: navigationKey,
      onGenerateRoute: OnGenerateRoute.route,
      builder: EasyLoading.init(),
    );
  }
}

var navigationKey = GlobalKey<NavigatorState>();
