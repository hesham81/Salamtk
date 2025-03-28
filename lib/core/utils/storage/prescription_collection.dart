import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/prescription/prescription_model.dart';

abstract class PrescriptionCollection {
  static final _firestore =
      FirebaseFirestore.instance.collection("Prescriptions");

  static CollectionReference<PrescriptionModel> _colRef() {
    return _firestore.withConverter<PrescriptionModel>(
      fromFirestore: (snapshot, _) =>
          PrescriptionModel.fromJson(snapshot.data()!),
      toFirestore: (prescription, _) => prescription.toJson(),
    );
  }

  static Future<String?> addPrescription({
    required PrescriptionModel model,
  }) async {
    try {
      await _colRef().doc(model.uid).set(model);
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  static Future<PrescriptionModel?> getPrescription({
    required String uid,
  }) async {
    try {
      var res = await _colRef().doc(uid).get();
      return res.data()!;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
