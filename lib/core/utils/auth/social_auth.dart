import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '/modules/layout/patient/pages/patient_home/pages/patient_home.dart';
import '/core/constant/shared_preference_key.dart';
import '/core/services/local_storage/shared_preference.dart';

abstract class SocialAuthServices {
  static loginWithGoogle(BuildContext context) async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    EasyLoading.show();

    await FirebaseAuth.instance.signInWithCredential(credential);
    EasyLoading.dismiss();

    SharedPreference.setString(SharedPreferenceKey.role, "patient");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => PatientHome(),
      ),
      (route) => false,
    );
  }
}
