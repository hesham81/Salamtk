import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salamtk/models/doctors_models/money_request.dart';

abstract class RequestsCollections {
  static final _firestore = FirebaseFirestore.instance.collection("Requests");
  static final String doctorId = FirebaseAuth.instance.currentUser!.uid;

  static CollectionReference<MoneyRequest> _collectionReference() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) =>
          MoneyRequest.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  static Future<String?> requestAmount({
    required double amount,
  }) async {
    try {
      MoneyRequest model = MoneyRequest(
        doctorId: doctorId,
        date: DateTime.now(),
        amount: amount,
      );
      await _collectionReference().doc(doctorId).set(model);
    } catch (error) {
      return error.toString();
    }
    return null;
  }

  static Future<MoneyRequest?> getCurrentRequestRunning() async {
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
}
