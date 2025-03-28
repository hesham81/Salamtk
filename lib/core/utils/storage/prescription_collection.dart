import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/prescription/prescription_model.dart';

abstract class PrescriptionStorageServices {
  static final _firebase =
      FirebaseFirestore.instance.collection("prescription");

  static CollectionReference<PrescriptionModel> _colRef() {
    return _firebase.withConverter(
      fromFirestore: (snapshot, options) =>
          PrescriptionModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  static Future<void> addPrescription(PrescriptionModel prescription) async {
    await _colRef().add(prescription);
  }

  static Future<void> updatePrescription(PrescriptionModel prescription) async {
    await _colRef().doc(prescription.uid).update(prescription.toJson());
  }

  static Future<void> deletePrescription(String uid) async {
    await _colRef().doc(uid).delete();
  }

  static Future<bool> checkIfExists(String uid) async {
    try {
      await _colRef().doc(uid).get();
      return true;
    } catch (e) {
      return false;
    }
  }
}
