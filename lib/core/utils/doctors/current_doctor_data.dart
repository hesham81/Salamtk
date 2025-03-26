import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/doctors_models/doctor_model.dart';

abstract class CurrentDoctorsData {
  static final _firestore = FirebaseFirestore.instance.collection("doctors");

  static CollectionReference<DoctorModel> _collectionReference() {
    return _firestore.withConverter<DoctorModel>(
      fromFirestore: (snapshot, _) => DoctorModel.fromJson(snapshot.data()!),
      toFirestore: (doctor, _) => doctor.toJson(),
    );
  }

  static Stream<DocumentSnapshot<DoctorModel>> getDoctors(String uid) =>
      _collectionReference().doc(uid).snapshots();
}
