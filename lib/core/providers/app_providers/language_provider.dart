import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _lang = "ar";

  String get getLanguage => _lang;

  void setLang(String lang) {
    _lang = lang;
    notifyListeners();
  }
}