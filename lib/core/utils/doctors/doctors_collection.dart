import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/doctors_models/doctor_model.dart';

abstract class DoctorsCollection {
  static final _firestore = FirebaseFirestore.instance.collection("doctors");

  static Stream<QuerySnapshot<DoctorModel>> getDoctors() =>
      _collectionReference().snapshots();

  static CollectionReference<DoctorModel> _collectionReference() {
    return _firestore.withConverter<DoctorModel>(
      fromFirestore: (snapshot, _) => DoctorModel.fromJson(snapshot.data()!),
      toFirestore: (doctor, _) => doctor.toJson(),
    );
  }

  static Future<bool> setDoctor(DoctorModel doctor) async {
    try {
      await _collectionReference().doc(doctor.uid).set(doctor);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<DoctorModel?> getDoctorData({
    required String uid,
  }) async {
    try {
      var res = await _collectionReference()
          .where(
            "uid",
            isEqualTo: uid,
          )
          .get();
      return res.docs.first.data();
    } catch (error) {
      return null;
    }
  }

  static Future<List<DoctorModel>?> getListOfDoctors({
    required String phoneNumber,
  }) async {
    try {
      var res = await _collectionReference().where(
        "uid",
        isEqualTo: phoneNumber,
      );
      return res
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
    } catch (error) {
      return null;
    }
  }

  static Future<bool> updateDoctor(DoctorModel doctor) async {
    try {
      doctor.isInTheClinic = !doctor.isInTheClinic;
      await _collectionReference().doc(doctor.uid).set(doctor);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<List<DoctorModel>> doctors() async {
    try {
      // Get the first snapshot from the stream
      final querySnapshot = await DoctorsCollection.getDoctors().first;

      // Map the documents to DoctorModel objects
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (error) {
      // Log the error and rethrow it
      print('Error fetching doctors: $error');
      rethrow;
    }
  }
}
