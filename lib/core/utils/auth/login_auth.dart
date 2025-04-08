import 'package:firebase_auth/firebase_auth.dart';
import '/core/utils/auth/auth_collections.dart';

abstract class LoginAuth {
  static final _firebase = FirebaseAuth.instance;
  static String? _role;

  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential? user = await _firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user.user != null) {
        _role = await AuthCollections.getRole(uid: user.user!.uid);
      }
      return _role;
    } on FirebaseAuthException catch (e) {
      e.toString();
      return null;
    }
  }

  static Future<String?> forgetPassword({
    required String email,
  }) async {
    try {
      await _firebase.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  static Future<bool> logout() async {
    try {
      await _firebase.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      e.toString();
      return false;
    }
  }
}
