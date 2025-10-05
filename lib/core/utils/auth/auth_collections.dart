import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthCollections {
  static final _firestore = FirebaseFirestore.instance.collection("users");

  static Future<String?> insertRole({
    required String uid,
    String? role,
    String? specialist,
    String? phoneNumber,
    String? hashedPassword,
  }) async {
    try {
      log("[Authentication] Start Working With The User Role");
      await _firestore.doc(uid).set({
        "uid": uid,
        "role": role ?? "patient",
        "specialist": specialist,
        "phoneNumber": phoneNumber,
        "hashedPassword": hashedPassword,
        "basedPassword": hashedPassword,
      });
      log("[Authentication] User Role Inserted Successfully ${hashedPassword}");
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  static Future<String?> getPhoneNumber() async {
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      print("The Debug: $uid");
      var res = await _firestore.doc(uid).get().then(
            (value) => value.data(),
          );
      print("The Debug: ${res}");
      return res?["phoneNumber"] ?? null;
    } catch (error) {
      return null;
    }
  }

  static Future<String?> getPassword() async {
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      print("The Debug: $uid");
      var res = await _firestore.doc(uid).get().then(
            (value) => value.data(),
      );
      print("The Debug: ${res}");
      return res?["hashedPassword"] ?? null;
    } catch (error) {
      return null;
    }
  }

  static Future<String?> changePassword(String newHashedPassword) async {
    try {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      print("The Debug: $uid");

      // Get current data
      var doc = await _firestore.doc(uid).get();
      var currentData = doc.data();
      print("The Debug: ${currentData}");

      // Update the hashedPassword field (you need to provide the new hashed password)
      // Since you didn't specify where the new hash comes from, I'll assume you have it
      // String newHashedPassword = "YOUR_NEW_HASHED_PASSWORD_HERE"; // Replace this

      await _firestore.doc(uid).update({
        'hashedPassword': newHashedPassword,
      });

      return newHashedPassword;
    } catch (error) {
      print("Error: $error");
      return null;
    }
  }



  static Future<String?> getRole({
    required String uid,
  }) async {
    try {
      var res = await _firestore.doc(uid).get();
      return res.data()!["role"];
    } catch (error) {
      return null;
    }
  }
}
