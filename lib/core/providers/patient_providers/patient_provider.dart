import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/core/utils/patients/favoutie_collections.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/core/utils/reservations/reservation_collection.dart';
import '/models/reservations_models/reservation_model.dart';
import '/models/doctors_models/doctor_model.dart';

class PatientProvider extends ChangeNotifier {
  DoctorModel? _selectedDoctor;
  String? _selectedSlot;
  List<String> favourites = [];
  String? _selectedPhoneNumber;

  String? _userPhoneNumber;

  bool? _isPayValid;

  String? _selectedCity;
  String? _selectedZone;

  String? _screenshot;

  File? _image;

  String? get getScreenshot => _screenshot;

  String? appPhoneNumber;

  String? get getSelectedCity => _selectedCity;

  String? get getSelectedZone => _selectedZone;

  void setSelectedCity(String? value) {
    _selectedCity = value;
    notifyListeners();
  }

  void setSelectedZone(String? value) {
    _selectedZone = value;
    notifyListeners();
  }

  void setAppPhoneNumber(String? value) {
    appPhoneNumber = value;
    notifyListeners();
  }

  String? get getAppPhoneNumber => appPhoneNumber;

  void setIsPayValid(bool? value) {
    _isPayValid = value;
    notifyListeners();
  }

  void disposeData() {
    _image = null;
    _screenshot = null;
    _userPhoneNumber = null;
    _selectedPhoneNumber = null;
    _isPayValid = null;
    _selectedPhoneNumber = null;
    _selectedSlot = null;
    _selectedDate = null;
    notifyListeners();
  }

  bool? get getIsPayValid => _isPayValid;

  void setScreenshot(String value) {
    _screenshot = value;
    notifyListeners();
  }

  void setUserPhoneNumber(String value) {
    _userPhoneNumber = value;
    notifyListeners();
  }

  String? get getUserPhoneNumber => _userPhoneNumber;

  void setPhoneNumber(String value) {
    _selectedPhoneNumber = value;
    notifyListeners();
  }

  String? get getPhoneNumber => _selectedPhoneNumber;

  void setImage(File? value) {
    _image = value;
    notifyListeners();
  }

  File? get getImage => _image;

  List<ReservationModel> _reservations = [];
  List<Map<String, dynamic>> categories = [
    // First Screen
    {
      "icon": "assets/icons/categorize/Obstetrics & Gynecology.jpg",
      "text": "Obstetrics & Gynecology",
      "color": Colors.orangeAccent,
    },
    {
      "icon": "assets/icons/categorize/dentist.jpg",
      "text": "Teeth",
      "color": Colors.orangeAccent,
    },
    {
      "icon": "assets/icons/categorize/Urology.jpg",
      // Assuming this is for Urology
      "text": "Urology",
      "color": Colors.red,
    },
    {
      "icon": "assets/icons/lung.png",
      "text": "Lung",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/categorize/Pediatrics.jpg",
      // Assuming this is for Pediatrics
      "text": "Pediatrics",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/categorize/psychologist.jpg",
      "text": "Psychiatry",
      "color": Colors.blue,
    },
    {
      "icon": "assets/icons/categorize/ENT.jpg", // Assuming this is for ENT
      "text": "Ear, Nose & Throat (ENT)",
      "color": Colors.redAccent,
    },
    {
      "icon": "assets/icons/categorize/Dermatology.jpg",
      "text": "Dermatology",
      "color": Colors.orangeAccent,
    },

    // Second Screen
    {
      "icon": "assets/icons/categorize/Orthopedics.jpg",
      "text": "Orthopedics",
      "color": AppColors.secondaryColor,
    },
    {
      "icon": "assets/icons/categorize/Ophthalmology.jpg",
      "text": "Eye",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/categorize/Cardiology.jpg",
      "text": "Cardiology",
      "color": Colors.red,
    },
    {
      "icon": "assets/icons/categorize/Nutritionist.jpg",
      "text": "Nutritionist",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/categorize/Family Medicine & Allergy.jpg",
      // Assuming this is for Family Medicine & Allergy
      "text": "Family Medicine & Allergy",
      "color": Colors.orangeAccent,
    },
    {
      "icon": "assets/icons/categorize/Orthopedic & Spinal Surgery.jpg",
      // Assuming this is for Orthopedic & Spinal Surgery
      "text": "Orthopedic & Spinal Surgery",
      "color": Colors.redAccent,
    },
    {
      "icon": "assets/icons/categorize/Gastroenterology.jpg",
      // Assuming this is for Gastroenterology
      "text": "Gastroenterology",
      "color": Colors.orangeAccent,
    },

    // Third Screen
    {
      "icon": "assets/icons/elbatna_icon.jpg",
      "text": "Internal Medicine",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/surgery_icon.jpg",
      "text": "Surgery",
      "color": Colors.blue,
    },
    {
      "icon": "assets/icons/categorize/Acupuncture.jpg",
      // Assuming this is for Acupuncture
      "text": "Acupuncture",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/categorize/Vascular Surgery.jpg",
      // Assuming this is for Vascular Surgery
      "text": "Vascular Surgery",
      "color": Colors.blueAccent,
    },
    {
      "icon": "assets/icons/categorize/Nephrology.jpg",
      // Assuming this is for Nephrology
      "text": "Nephrology",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/categorize/Radiology.jpg",
      // Assuming this is for Radiology
      "text": "Radiology",
      "color": Colors.orangeAccent,
    },
    {
      "icon": "assets/icons/categorize/Endocrinology.jpg",
      // Assuming this is for Endocrinology
      "text": "Endocrinology",
      "color": Colors.orangeAccent,
    },

    // Fourth Screen
    {
      "icon": "assets/icons/categorize/Genetics.jpg",
      // Assuming this is for Genetics
      "text": "Genetics",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/categorize/Speech Therapy.jpg",
      // Assuming this is for Speech Therapy
      "text": "Speech Therapy",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/categorize/Pain Management.jpg",
      // Assuming this is for Pain Management
      "text": "Pain Management",
      "color": Colors.green,
    },
    {
      "icon": "assets/icons/categorize/Cosmetic Surgery.jpg",
      // Assuming this is for Cosmetic Surgery
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

  _initFavourites() async {
    User? user = await FirebaseAuth.instance.currentUser;
    await FavouriteCollections.getFavourite(user!.uid).listen(
      (event) {
        for (var element in event.data()?.favouriteDoctors ?? []) {
          favourites = element;
        }
      },
    );
  }

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
