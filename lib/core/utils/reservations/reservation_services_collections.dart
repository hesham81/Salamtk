import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/reservations_models/reservation_model.dart';

abstract class ReservationServicesCollections {
  static final _firestore =
      FirebaseFirestore.instance.collection("Reservation");

  static CollectionReference<ReservationModel> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) => ReservationModel.fromJson(
        snapshot.data()!,
      ),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  static Future<bool?> checkIfSlotIsReservedOrNot({
    required DateTime date,
    required String slot,
  }) async {
    try {
      var res = await _colRef().get();
      List<ReservationModel> list = res.docs
          .map(
            (e) => e.data(),
          )
          .toList();
      for (var reservation in list) {
        if (reservation.date.day == date.day &&
            reservation.date.month == date.month &&
            reservation.slot == slot) {
          return true;
        }
      }
      return false;
    } catch (error) {
      return null;
    }
  }
}
