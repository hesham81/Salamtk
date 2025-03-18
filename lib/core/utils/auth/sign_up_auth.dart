import 'package:firebase_auth/firebase_auth.dart';
import '/core/utils/auth/auth_collections.dart';

abstract class SignUpAuth {
  static final _firebase = FirebaseAuth.instance;

  static Future<String?> signUp({
    required String email,
    required String password,
    required String name,
    String? phoneNumber,
    String? specialist,
    bool isDoctor = false,
  }) async {
    try {
      UserCredential? user = await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.user!.updateDisplayName(name);
      await AuthCollections.insertRole(
        uid: user.user!.uid,
        role: isDoctor ? "doctor" : "patient",
        phoneNumber: phoneNumber,
        specialist: (isDoctor == true) ? specialist : null,
      ).then(
        (value) {
          return value;
        },
      );
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
