import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import '/core/utils/doctors/doctors_collection.dart';
import '/core/utils/reservations/reservation_collection.dart';
import '/models/doctors_models/doctor_model.dart';
import '/models/reservations_models/reservation_model.dart';

class AllAppProvidersDb extends ChangeNotifier {
  List<String> _citiesOfDoctors = [];
  List<DoctorModel> _doctors = [];
  List<String> _slots = [];
  List<String> doctorsSlots = [];

  DateTime _date = DateTime.now();
  DoctorModel? _doctor;
  List<ReservationModel> _reservations = [];
  loc.LocationData? _currentLocation;
  loc.Location _location = loc.Location();

  String? _city;

  String? _state;

  String? _street;

  String? _country;

  LatLng get lo => LatLng(
        _currentLocation?.latitude ?? 0,
        _currentLocation?.longitude ?? 0,
      );

  String? get city => _city;

  List<String> _cities = [];
  List<String> _areas = [];

  String? get state => _state;

  String? get street => _street;

  String? get country => _country;
  bool _serviceEnabled = false;


  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }
      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }
      _currentLocation = await _location.getLocation();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentLocation?.latitude ?? 0,
        _currentLocation?.longitude ?? 0,
      );
      _city = placemarks[0].locality;
      _state = placemarks[0].administrativeArea;
      _street = placemarks[0].thoroughfare;
      _country = placemarks[0].country;
      notifyListeners();
    } catch (e) {
      throw Exception('Error getting current location: $e');
    }
  }

  // Getters
  List<String> get getAllCitiesOfDoctors => _citiesOfDoctors;

  List<String> get getAllSlots => _slots;

  List<DoctorModel> get getAllDoctors => _doctors;

  // Constructor
  AllAppProvidersDb() {
    Future.wait(
      [
        _getCurrentLocation(),
      ],
    );
    initializeData();
  }

  // Initialize data asynchronously
  Future<void> initializeData() async {
    await _getAllCitiesOfDoctors();
    await _getAllSlots();
    notifyListeners();
  }

  Future<void> _getAllReservations() async {
    _reservations = await ReservationCollection.getAllReservations();
    notifyListeners();
  }

  Future<void> _getAllCitiesOfDoctors() async {
    _doctors = await DoctorsCollection.doctors();
    _citiesOfDoctors.clear(); // Clear existing cities to avoid duplicates
    for (var doctor in _doctors) {
      if (!_citiesOfDoctors.contains(doctor.city)) {
        _citiesOfDoctors.add(doctor.city);
      }
    }
  }

  Future<void> checkSlots({
    required DateTime date,
    required DoctorModel doctor,
  }) async {
    _date = date;
    _doctor = doctor;
    await _getAllReservations();
    await _getAllSlots();
    notifyListeners();
  }

  Future<void> _getAllSlots() async {
    if (_reservations.isEmpty) {
      _reservations = await ReservationCollection.getAllReservations();
    }

    List<ReservationModel> filteredReservations = _reservations
        .where((element) =>
            element.date.isAtSameMomentAs(_date) &&
            element.doctorId == _doctor!.uid)
        .toList();

    _slots.clear();

    for (var reservation in filteredReservations) {
      _slots.add(reservation.slot);
    }
  }
}
