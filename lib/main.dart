import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:salamtk/core/providers/sign_up_providers/sign_up_providers.dart';
import '/core/providers/app_providers/all_app_providers_db.dart';
import '/core/providers/reservations_providers/reservations_provider.dart';
import '/core/constant/storage/storage_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/core/providers/app_providers/language_provider.dart';
import '/core/providers/patient_providers/patient_provider.dart';
import '/core/route/on_generate_route.dart';
import '/core/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/services/loading_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configLoading();
  await Supabase.initialize(
    url: StorageKeys.projectUrl,
    anonKey: StorageKeys.apiKey,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => AllAppProvidersDb()),
        ChangeNotifierProvider(create: (_) => SignUpProviders()),
        ChangeNotifierProvider(create: (_) => ReservationsProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.getLanguage),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      navigatorKey: navigationKey,
      onGenerateRoute: OnGenerateRoute.route,
      builder: EasyLoading.init(),
    );
  }
}

var navigationKey = GlobalKey<NavigatorState>();
