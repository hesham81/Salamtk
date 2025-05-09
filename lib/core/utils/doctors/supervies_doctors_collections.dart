import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salamtk/models/doctors_models/supervised_doctors_model.dart';

abstract class SupervisesDoctorsCollections {
  static final _firestore =
      FirebaseFirestore.instance.collection("supervisedDoctors");
  static final _currentDoctorId = FirebaseAuth.instance.currentUser?.uid;

  static CollectionReference<SupervisedDoctorsModel> _collectionRef() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) =>
            SupervisedDoctorsModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );

  static Future<void> addDoctor({
    required String doctorId,
  }) async {
    try {
      SupervisedDoctorsModel res =
          await _collectionRef().doc(_currentDoctorId).get().then(
                (value) => value.data()!,
              );
      res.doctors.add(doctorId);
      await _collectionRef().doc(_currentDoctorId).set(res);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool> removeDoctor({
    required String doctorId,
  }) async {
    try {
      SupervisedDoctorsModel res =
          await _collectionRef().doc(_currentDoctorId).get().then(
                (value) => value.data()!,
              );
      res.doctors.remove(doctorId);
      await _collectionRef().doc(_currentDoctorId).set(res);
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }
}
