import 'dart:developer';

import 'package:encrypt/encrypt.dart';

abstract class SecurityServices {
  static String encryptPassword({
    required String password,
  }) {
    final key = Key.fromUtf8('my 32 length key................');

    final iv = IV.fromLength(16);

    var encrypter = Encrypter(
      AES(
        key,
      ),
    );
    // log("This Is Encrypted Password: ${encrypter.encrypt(
    //       password,
    //       iv: iv,
    //     ).base64}");

    return encrypter
        .encrypt(
          password,
          iv: iv,
        )
        .base64;
    // var encryptedPassword =
  }

  static bool decryptPassword({
    required String password,
    required String hashedPassword,
  }) {
    try {
      final key = Key.fromUtf8('my 32 length key................');

      final iv = IV.fromLength(16);

      var encrypter = Encrypter(
        AES(
          key,
        ),
      );
      var decryptedPassword = encrypter.decrypt(
        encrypter.encrypt(
          password,
          iv: iv,
        ),
        iv: iv,
      );
      // log("This Is Decrypted Password: $decryptedPassword");
      if (decryptedPassword == hashedPassword) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
