import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OtpServices {
  static String email =
      FirebaseAuth.instance.currentUser?.email ?? "heshamaymen8@gmail.com";

  static Future<void> sendOtp() async {
    await EmailOTP.sendOTP(email: email);
  }
  static getOtp()
  {
    return EmailOTP.getOTP();
  }

  static Future<bool?> verifyOtp(String otp) async {
    if (EmailOTP.isOtpExpired()) {
      sendOtp();
      return null;
    }

    return await EmailOTP.verifyOTP(otp: otp);
  }

  static Future<void> resendOtp() async {
    await EmailOTP.getOTP();
  }
}
