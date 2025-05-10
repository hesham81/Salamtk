import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/money/money_request_model.dart';

abstract class RequestsCollections {
  static final _firestore = FirebaseFirestore.instance.collection("Requests");
  static final String doctorId = FirebaseAuth.instance.currentUser!.uid;

  static CollectionReference<MoneyRequestModel> _collectionReference() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) =>
          MoneyRequestModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  static Future<String?> requestAmount({
    required double amount,
    required String phoneNumber,
  }) async {
    try {
      MoneyRequestModel model = MoneyRequestModel(
        doctorId: doctorId,
        phoneNumber: phoneNumber,
        amount: amount,
        date: DateTime.now(),
        isVerified: true,
        requestId: "",
      );
      await _collectionReference().doc(model.requestId).set(model);
    } catch (error) {
      return error.toString();
    }
    return null;
  }

  static Future<MoneyRequestModel?> getCurrentRequestRunning() async {
    try {
      var querySnapshot = await _collectionReference()
          .where("doctorId", isEqualTo: doctorId)
          .where("status", isEqualTo: "Pending")
          .get();
      if (querySnapshot.docs.isNotEmpty) return querySnapshot.docs.first.data();
      return null;
    } catch (error) {
      return null;
    }
  }

  static Future<List<MoneyRequestModel>> getAllRequests() async {
    try {
      List<MoneyRequestModel> requests =
          await _collectionReference().get().then(
                (value) => value.docs
                    .map(
                      (e) => e.data(),
                    )
                    .toList(),
              );
      List<MoneyRequestModel> doctorsRequests = requests
          .where(
            (element) => element.doctorId == FirebaseAuth.instance.currentUser!.uid,
          )
          .toList();
      return doctorsRequests;
    } catch (error) {
      return [];
    }
  }

}
