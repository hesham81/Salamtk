import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PhoneNumberAuth {
  static final _firestore =
      FirebaseFirestore.instance.collection("PhoneNumbers");

  static Future<bool> checkIfExist({
    required String phoneNumber,
  }) async {
    try {
      var res = await _firestore.doc(phoneNumber).get();
      return res.exists
          ? (res.data()!["isVerified"])
              ? true
              : false
          : false;
    } catch (error) {
      return false;
    }
  }

  static String _generateRandomString(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final rnd = Random();
    final buffer = StringBuffer();

    for (var i = 0; i < length; i++) {
      buffer.write(chars[rnd.nextInt(chars.length)]);
    }

    return buffer.toString();
  }

  static Future<String?> signUpWithPhoneNumber({
    required String phoneNumber,
    required String name,
  }) async {
    try {
      await _firestore.doc(phoneNumber).set({
        "phoneNumber": phoneNumber,
        "name": name,
        "uid": _generateRandomString(28),
        "isVerified": false,
      });
      log(1);
      return null;
    } catch (error) {
      throw Exception(error);
    }
  }

  static Future<String?> getToken({
    required String phoneNumber,
  }) async {
    try {
      var res = await _firestore.doc(phoneNumber).get().then(
            (value) => value.data()?["uid"],
          );
      return res;
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
