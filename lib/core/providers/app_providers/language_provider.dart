import 'package:flutter/material.dart';
import '/core/constant/shared_preference_key.dart';
import '/core/services/local_storage/shared_preference.dart';

class LanguageProvider extends ChangeNotifier {
  String? _lang;

  LanguageProvider() {
    _init();
  }

  Future<void> _init() async {
    _lang =
        (await SharedPreference.getString(SharedPreferenceKey.lang)) ?? "ar";
    String? value =
        await SharedPreference.getString(SharedPreferenceKey.lang).then(
      (value) => value,
    );
    if (value == null) {
      _changeLocalStorage();
    }
    notifyListeners();
  }

  String get getLanguage => _lang?? "ar";

  void setLang(String lang) {
    _lang = lang;
    notifyListeners();
    _changeLocalStorage();
  }

  Future<void> _changeLocalStorage() async {
    await SharedPreference.setString(SharedPreferenceKey.lang, _lang!);
  }
}
