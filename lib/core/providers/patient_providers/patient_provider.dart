import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/core/utils/reservations/reservation_collection.dart';
import '/models/reservations_models/reservation_model.dart';
import '/models/doctors_models/doctor_model.dart';

class PatientProvider extends ChangeNotifier {
  DoctorModel? _selectedDoctor;
  String? _selectedSlot;
  List<ReservationModel> _reservations = [];
  List<Map<String, dynamic>> categories = [
    // First Screen
    {
      "icon": "assets/icons/womens.svg",
      "text": "Obstetrics & Gynecology",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/teeth.png",
      "text": "Dentistry",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/urologist.jpg", // Assuming this is for Urology
      "text": "Urology",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/lung.png",
      "text": "Chest & Respiratory System",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/pediatrics.jpg", // Assuming this is for Pediatrics
      "text": "Pediatrics",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/psychologist.jpg",
      "text": "Psychiatry",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/ent.svg", // Assuming this is for ENT
      "text": "Ear, Nose & Throat (ENT)",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/dermatologist.jpg",
      "text": "Dermatology",
      "color": Colors.green,
    },

    // Second Screen
    {
      "icon": "assets/icons/orthopedic_doctor.jpg",
      "text": "Orthopedics",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/eye.png",
      "text": "Ophthalmology",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/heart.jpg",
      "text": "Cardiology",
      "color": Colors.red,
    },
    {
      "icon": "assets/icons/nutritionist.jpg",
      "text": "Nutritionist",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/allergy.jpg", // Assuming this is for Family Medicine & Allergy
      "text": "Family Medicine & Allergy",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/general_doctor_icon.jpg",
      "text": "General Practitioner",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/spine_surgery.jpg", // Assuming this is for Orthopedic & Spinal Surgery
      "text": "Orthopedic & Spinal Surgery",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/gastroenterologist.jpg", // Assuming this is for Gastroenterology
      "text": "Gastroenterology",
      "color": Colors.green,
    },

    // Third Screen
    {
      "icon": "assets/icons/elbatna_icon.jpg",
      "text": "Internal Medicine",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/surgery_icon.jpg",
      "text": "General Surgery",
      "color": Colors.blue,
    },
    {
      "icon": "assets/icons/acupuncture.jpg", // Assuming this is for Acupuncture
      "text": "Acupuncture",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/prosthetics.jpg", // Assuming this is for Prosthetics & Assistive Devices
      "text": "Prosthetics & Assistive Devices",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/blood_vessels_surgery.jpg", // Assuming this is for Vascular Surgery
      "text": "Vascular Surgery",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/kidney.jpg", // Assuming this is for Nephrology
      "text": "Nephrology",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/radiology.jpg", // Assuming this is for Radiology
      "text": "Radiology",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/endocrinology.jpg", // Assuming this is for Endocrinology
      "text": "Endocrinology",
      "color": Colors.green,
    },

    // Fourth Screen
    {
      "icon": "assets/icons/genetics.jpg", // Assuming this is for Genetics
      "text": "Genetics",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/speech_therapy.jpg", // Assuming this is for Speech Therapy
      "text": "Speech Therapy",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/pain_management.jpg", // Assuming this is for Pain Management
      "text": "Pain Management",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/cosmetic_surgery.jpg", // Assuming this is for Cosmetic Surgery
      "text": "Cosmetic Surgery",
      "color": Colors.green,
    },
  ];
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
    _totalReservations = 0;
    checkReservations();
  }

  void removeData() {
    _selectedDoctor = null;
    _selectedSlot = null;
    _selectedDate = null;
    _selectedPaymentMethod = null;
  }

  Future<void> checkReservations() async {
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

  late int _totalReservations;

  void setTotalReservations(int value) {
    _totalReservations = value;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }

  int get getTotalReservations => _totalReservations;

  Future<DoctorModel?> searchForDoctor({
    required String doctorPhoneNumber,
  }) async {
    DoctorModel? doctor = await DoctorsCollection.getDoctorData(
      uid: doctorPhoneNumber,
    );
    return doctor;
  }
}
