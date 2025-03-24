import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/core/utils/reservations/reservation_collection.dart';
import '/models/reservations_models/reservation_model.dart';
import '/models/doctors_models/doctor_model.dart';

class PatientProvider extends ChangeNotifier {
  DoctorModel? _selectedDoctor;
  String? _selectedSlot;
  List<ReservationModel> _reservations = [];

  DateTime? _selectedDate;
  String? _selectedPaymentMethod;

  void addReservation(ReservationModel reservation) {
    _reservations.add(reservation);
    notifyListeners();
  }

  void removeReservation(ReservationModel reservation) {
    _reservations.remove(reservation);
    notifyListeners();
  }

  PatientProvider() {
    _checkReservations();
  }



  Future<void> _checkReservations() async {
    try {
      _reservations.clear();
      var userId = await FirebaseAuth.instance.currentUser!.uid;
      _reservations = await ReservationCollection.getReservations(
        patientId: userId,
      );
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  //setters

  void setSelectedPaymentMethod(String paymentMethod) {
    _selectedPaymentMethod = paymentMethod;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedSlot(String slot) {
    _selectedSlot = slot;
    notifyListeners();
  }

  void setSelectedDoctor(DoctorModel doctorModel) {
    _selectedDoctor = doctorModel;
    notifyListeners();
  }

  void clearSelectedDoctor() {
    _selectedDoctor = null;
    notifyListeners();
  }

  //getter

  bool get isDoctorSelected => _selectedDoctor != null ? true : false;

  DoctorModel? get getDoctor => _selectedDoctor;

  String? get getPaymentMethod => _selectedPaymentMethod;

  DateTime? get getSelectedDate => _selectedDate;

  String? get getSelectedSlot => _selectedSlot;

  List<ReservationModel> get getReservations => _reservations;

   Future<DoctorModel?> searchForDoctor({
    required String doctorPhoneNumber,
  }) async {
    DoctorModel? doctor = await DoctorsCollection.getDoctorData(
      phoneNumber: doctorPhoneNumber,
    );
    return doctor;
  }
}
