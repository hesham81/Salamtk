import '/core/utils/doctors/doctors_collection.dart';
import '/models/reservations_models/reservation_model.dart';

class AnalyseReservationModel {
  final ReservationModel model;

  AnalyseReservationModel({
    required this.model,
  });

  getDoctorData() {
    return DoctorsCollection.getDoctorData(uid: model.doctorId);
  }
}
