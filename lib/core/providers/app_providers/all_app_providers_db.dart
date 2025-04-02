import 'package:flutter/material.dart';
import 'package:salamtk/core/utils/doctors/doctors_collection.dart';
import 'package:salamtk/core/utils/reservations/reservation_collection.dart';
import 'package:salamtk/models/doctors_models/doctor_model.dart';
import 'package:salamtk/models/reservations_models/reservation_model.dart';

class AllAppProvidersDb extends ChangeNotifier {
  List<String> _citiesOfDoctors = [];

  List<DoctorModel> _doctors = [];

  List<String> _slots = [];

  List<ReservationModel> _reservations = [];

  List<String> get getAllCitiesOfDoctors => _citiesOfDoctors;

  List<String> get getAllSlots => _slots;

  List<DoctorModel> get getAllDoctors => _doctors;

  AllAppProvidersDb() {
    _getAllCitiesOfDoctors();
    _getAllSlots();
    notifyListeners();
  }

  _getAllCitiesOfDoctors() async {
    await DoctorsCollection.doctors().then(
      (value) => _doctors = value,
    );
    for (var doctor in _doctors) {
      if (!_citiesOfDoctors.contains(doctor.city)) {
        _citiesOfDoctors.add(doctor.city);
      }
    }
  }

  _getAllSlots() async {
    await ReservationCollection.getAllReservations().then(
      (value) => _reservations = value,
    );
    for (var reservation in _reservations) {
      _slots.add(reservation.slot);
    }
    for (var slot in _slots) {
      print(slot);
    }
  }
}
