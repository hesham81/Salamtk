import 'package:flutter/material.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/core/utils/reservations/reservation_collection.dart';
import '/models/doctors_models/doctor_model.dart';
import '/models/reservations_models/reservation_model.dart';

class AllAppProvidersDb extends ChangeNotifier {
  List<String> _citiesOfDoctors = [];
  List<DoctorModel> _doctors = [];
  List<String> _slots = [];
  DateTime _date = DateTime.now();
  DoctorModel? _doctor;
  List<ReservationModel> _reservations = [];

  // Getters
  List<String> get getAllCitiesOfDoctors => _citiesOfDoctors;
  List<String> get getAllSlots => _slots;
  List<DoctorModel> get getAllDoctors => _doctors;

  // Constructor
  AllAppProvidersDb() {
    initializeData();
  }

  // Initialize data asynchronously
  Future<void> initializeData() async {
    await _getAllCitiesOfDoctors();
    await _getAllSlots();
    notifyListeners();
  }

  // Fetch all cities of doctors
  Future<void> _getAllCitiesOfDoctors() async {
    _doctors = await DoctorsCollection.doctors();
    _citiesOfDoctors.clear(); // Clear existing cities to avoid duplicates
    for (var doctor in _doctors) {
      if (!_citiesOfDoctors.contains(doctor.city)) {
        _citiesOfDoctors.add(doctor.city);
      }
    }
  }

  // Check slots for a specific date and doctor
  void checkSlots({
    required DateTime date,
    required DoctorModel doctor,
  }) {
    _date = date;
    _doctor = doctor;
    _slots.clear(); // Clear existing slots before fetching new ones
    notifyListeners();
    _getAllSlots();
  }

  // Fetch all slots for the selected date
  Future<void> _getAllSlots() async {
    if (_reservations.isEmpty) {
      _reservations = await ReservationCollection.getAllReservations();
    }

    // Filter reservations based on the selected date
    List<ReservationModel> filteredReservations = _reservations.where((element) =>
        element.date.isAtSameMomentAs(_date) && element.doctorId== _doctor!.uid).toList();

    // Clear existing slots to avoid duplicates
    _slots.clear();

    // Add slots from filtered reservations
    for (var reservation in filteredReservations) {
      _slots.add(reservation.slot);
    }

    // Print debug information
    print('Filtered Reservations Count: ${filteredReservations.length}');
    print('Slots: $_slots');
  }
}