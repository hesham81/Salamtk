import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/reservations_models/reservation_model.dart';

abstract class ReservationCollection {
  static final _firestore =
      FirebaseFirestore.instance.collection("Reservation");

  static CollectionReference<ReservationModel> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) =>
          ReservationModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  static Future<bool> addReservation(ReservationModel reservation) async {
    try {
      String id =
          "${reservation.email} ${reservation.date.day} ${reservation.slot}";
      reservation.reservationId = id;
      await _colRef().doc(reservation.reservationId).set(reservation);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<ReservationModel?> getReservationData({
    required String patientId,
  }) async {
    try {
      var res = await _colRef().where("email", isEqualTo: patientId).get();
      return res.docs.first.data();
    } catch (error) {
      return null;
    }
  }
}
