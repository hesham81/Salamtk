import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppProviders extends ChangeNotifier {
  User? _cred;

  AppProviders() {
    _getToken();
  }

  User? get cred => _cred;



  static _getToken() async {
    User? user = await FirebaseAuth.instance.currentUser;
  }
}
