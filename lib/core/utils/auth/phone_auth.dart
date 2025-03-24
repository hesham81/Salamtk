import 'package:firebase_auth/firebase_auth.dart';

abstract class PhoneAuth {
  static final _auth = FirebaseAuth.instance;

  static Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String verificationId) onCodeSent,
    required void Function(FirebaseAuthException error) onVerificationFailed,
    required void Function(PhoneAuthCredential credential) onVerificationCompleted,
    required void Function(String verificationId) onCodeAutoRetrievalTimeout,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          onVerificationCompleted(credential);
        },
        verificationFailed: (FirebaseAuthException error) {
          onVerificationFailed(error);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          onCodeAutoRetrievalTimeout(verificationId);
        },
      );
    } catch (e) {
      print("Error during phone verification: $e");
    }
  }

  static Future<UserCredential?> signInWithOTP({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print("Error signing in with OTP: $e");
      return null;
    }
  }
}