import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthCollections {
  static final _firestore = FirebaseFirestore.instance.collection("users");

  static Future<String?> insertRole({
    required String uid,
    String? role,
    String? specialist,
    String? phoneNumber,
  }) async {
    try {
      await _firestore.doc(uid).set({
        "uid": uid,
        "role": role ?? "patient",
        "specialist": specialist,
        "phoneNumber": phoneNumber,
      });
      return null;
    } catch (error) {
      return error.toString();
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
