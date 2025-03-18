import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpAuth {
  static final _firebase = FirebaseAuth.instance;

  static Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
