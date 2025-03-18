import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginAuth {
  static final _firebase = FirebaseAuth.instance;

  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
