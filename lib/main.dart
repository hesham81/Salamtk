import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/services/loading_indicator.dart';
import '/core/route/on_generate_route.dart';
import '/core/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configLoading();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PatientProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      navigatorKey: navigationKey,
      onGenerateRoute: OnGenerateRoute.route,
      builder: EasyLoading.init(),
    );
  }
}

var navigationKey = GlobalKey<NavigatorState>();
