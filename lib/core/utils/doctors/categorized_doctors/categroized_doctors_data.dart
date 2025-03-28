import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/doctors_models/doctor_model.dart';

abstract class CategorizedDoctorsData {
  static final _firestore = FirebaseFirestore.instance.collection("doctors");

  static CollectionReference<DoctorModel> _colRef() {
    return _firestore.withConverter<DoctorModel>(
      fromFirestore: (snapshot, _) => DoctorModel.fromJson(snapshot.data()!),
      toFirestore: (doctor, _) => doctor.toJson(),
    );
  }

  static Stream<QuerySnapshot<DoctorModel>> getCategorizedDoctors({
    required String category,
  }) {
    return _colRef().snapshots();
  }
}
