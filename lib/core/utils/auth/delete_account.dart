import 'package:firebase_auth/firebase_auth.dart';

abstract class DeleteAccount {
  static final _firebase = FirebaseAuth.instance;

  static Future<void> deleteAccount() async {
    await _firebase.currentUser!.delete();
  }
}
