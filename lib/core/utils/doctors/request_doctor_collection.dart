import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salamtk/core/utils/doctors/supervies_doctors_collections.dart';
import 'package:salamtk/models/doctors_models/request_doctor_data_model.dart';

abstract class RequestDoctorCollection {
  static final _firestore =
      FirebaseFirestore.instance.collection("supervisedRequests");

  static CollectionReference<RequestDoctorModel> _collectionReference() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) =>
            RequestDoctorModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );

  static Future<void> requestDoctor({
    required String doctorId,
  }) async {
    try {
      RequestDoctorModel request = RequestDoctorModel(doctorId: doctorId);
      await _firestore.doc(request.doctorId).set(request.toJson());
    } catch (error) {
      throw Exception(error.toString());
    }
  }
  static Future<void> acceptRequest({
    required String requestId,
  }) async {
    try {
      await _firestore.doc(requestId).update({"status": true});
      await SupervisesDoctorsCollections.addDoctor(doctorId: requestId);
    } catch (error) {
      throw Exception(error.toString());
    }
  }
  static  Stream<QuerySnapshot<RequestDoctorModel>> getStreamRequests() {
    return _collectionReference().snapshots();
  }
  static Future<void> deleteRequest({
    required String doctorId,
  }) async {
    try {
      var docs = await _collectionReference().get().then((value) => value.docs);
      for(var request in docs)
        {
          if(request.data().doctorId == doctorId)
            {
              await request.reference.delete();
            }
        }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
