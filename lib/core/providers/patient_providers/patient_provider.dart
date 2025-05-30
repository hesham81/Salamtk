import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salamtk/main.dart';
import '/core/utils/patients/favoutie_collections.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/core/utils/reservations/reservation_collection.dart';
import '/models/reservations_models/reservation_model.dart';
import '/models/doctors_models/doctor_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientProvider extends ChangeNotifier {
  DoctorModel? _selectedDoctor;
  String? _selectedSlot;
  List<String> favourites = [];
  String? _selectedPhoneNumber;
  String? _reservationPhoneNumber;
  bool _isContainReservations = false;
  String? _reservationName;
  String? _reservationEmail;
  String _providerPath = "";
  String _providerName = "";
  String? _userPhoneNumber;
  bool? _isPayValid;
  String? _selectedCity;
  String? _selectedZone;
  String? _screenshot;
  File? _image;
  String? appPhoneNumber;

  String? get getSelectedCity => _selectedCity;
  String? get getSelectedZone => _selectedZone;
  void setSelectedCity(String value) {
    _selectedCity = value;
    notifyListeners();
  }
  void setSelectedZone(String value) {
    _selectedZone = value;
    notifyListeners();
  }
  late int _totalReservations;
  List<ReservationModel> _reservations = [];

  AppLocalizations? local;

  void _checkLocal() {
    local = AppLocalizations.of(navigationKey.currentContext!);
    notifyListeners();
  }

  void reUpdateProvider() {
    _checkLocal();
  }

  // Categories Getter with dynamic localization
  List<Map<String, dynamic>> get categories {
    _checkLocal();
    return [
      {
        "icon": "assets/icons/categorize/Obstetrics & Gynecology.jpg",
        "text": local?.obstetrics,
        "color": Colors.orangeAccent,
      },
      {
        "icon": "assets/icons/categorize/dentist.jpg",
        "text": local?.teeth,
        "color": Colors.orangeAccent,
      },
      {
        "icon": "assets/icons/categorize/Urology.jpg",
        "text": local?.urology,
        "color": Colors.red,
      },
      {
        "icon": "assets/icons/lung.png",
        "text": local?.lung,
        "color": Colors.green,
      },
      {
        "icon": "assets/icons/categorize/Pediatrics.jpg",
        "text": local?.pediatrics,
        "color": Colors.green,
      },
      {
        "icon": "assets/icons/categorize/psychologist.jpg",
        "text": local?.psychiatry,
        "color": Colors.blue,
      },
      {
        "icon": "assets/icons/categorize/ENT.jpg",
        "text": local?.ent,
        "color": Colors.redAccent,
      },
      {
        "icon": "assets/icons/categorize/Dermatology.jpg",
        "text": local?.dermatology,
        "color": Colors.orangeAccent,
      },
      {
        "icon": "assets/icons/categorize/Orthopedics.jpg",
        "text": local?.orthopedics,
        "color": AppColors.secondaryColor,
      },
      {
        "icon": "assets/icons/categorize/Ophthalmology.jpg",
        "text": local?.eye,
        "color": Colors.green,
      },
      {
        "icon": "assets/icons/categorize/Cardiology.jpg",
        "text": local?.heart,
        "color": Colors.red,
      },
      {
        "icon": "assets/icons/categorize/Nutritionist.jpg",
        "text": local?.nutritionist,
        "color": Colors.green,
      },
      {
        "icon": "assets/icons/categorize/Family Medicine & Allergy.jpg",
        "text": local?.familyMedicineAndAllergy,
        "color": Colors.orangeAccent,
      },
      {
        "icon": "assets/icons/categorize/Gastroenterology.jpg",
        "text": local?.gastroenterology,
        "color": Colors.orangeAccent,
      },
      {
        "icon": "assets/icons/elbatna_icon.jpg",
        "text": local?.theInterior,
        "color": Colors.green,
      },
      {
        "icon": "assets/icons/surgery_icon.jpg",
        "text": local?.surgery,
        "color": Colors.blue,
      },
      {
        "icon": "assets/icons/categorize/Acupuncture.jpg",
        "text": local?.acupuncture,
        "color": Colors.green,
      },
      {
        "icon": "assets/icons/categorize/Vascular Surgery.jpg",
        "text": local?.vascularSurgery,
        "color": Colors.blueAccent,
      },
      {
        "icon": "assets/icons/categorize/Nephrology.jpg",
        "text": local?.nephrology,
        "color": Colors.green,
      },
      {
        "icon": "assets/icons/categorize/Radiology.jpg",
        "text": local?.radiology,
        "color": Colors.orangeAccent,
      },
      {
        "icon": "assets/icons/categorize/Endocrinology.jpg",
        "text": local?.endocrinology,
        "color": Colors.orangeAccent,
      },
      {
        "icon": "assets/icons/categorize/Genetics.jpg",
        "text": local?.genetics,
        "color": Colors.green,
      },
      {
        "icon": "assets/icons/categorize/Speech Therapy.jpg",
        "text": local?.speechTherapy,
        "color": Colors.green,
      },
      {
        "icon": "assets/icons/categorize/Pain Management.jpg",
        "text": local?.painManagement,
        "color": Colors.green,
      },
      {
        "icon": "assets/icons/categorize/Cosmetic Surgery.jpg",
        "text": local?.cosmeticSurgery,
        "color": Colors.green,
      },
    ];
  }

  DateTime? _selectedDate;
  String? _selectedPaymentMethod;

  Future<void> checkReservations() async {
    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      _reservations = await ReservationCollection.getReservations(patientId: userId);
      notifyListeners();
    } catch (error) {
      print("Error fetching reservations: $error");
    }
  }

  void addReservation(ReservationModel reservation) {
    _reservations.add(reservation);
    notifyListeners();
  }

  void removeReservation(ReservationModel reservation) {
    _reservations.remove(reservation);
    notifyListeners();
  }

  void setSelectedPaymentMethod(String paymentMethod) {
    _selectedPaymentMethod = paymentMethod;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  List<String> days = [
    "Monday", // 0
    "Tuesday", //1
    "Wednesday", //2
    "Thursday", // 3
    "Friday", // 4
    "Saturday", // 5
    "Sunday", //6
  ];

  List<String> _sortedDays = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
  ];

  int getDayIndex(int index) {
    return _sortedDays.indexOf(days[index]);
  }

  bool checkIsAllow(DateTime date) {
    int startIndex = _sortedDays.indexOf(_selectedDoctor!.clinicWorkingFrom);
    int endIndex = _sortedDays.indexOf(_selectedDoctor!.clinicWorkingTo);
    for (int index = startIndex; index <= endIndex; index++) {
      if (days[index] == date.weekday.toString()) {
        return true;
      }
    }
    return false;
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

  // Getters
  bool get getIsContainReservations => _isContainReservations;
  String? get reservationName => _reservationName;
  String? get reservationEmail => _reservationEmail;
  String? get reservationPhoneNumber => _reservationPhoneNumber;
  String get getProviderName => _providerName;
  String get getProviderPath => _providerPath;
  String? get getAppPhoneNumber => appPhoneNumber;
  bool? get getIsPayValid => _isPayValid;
  String? get getUserPhoneNumber => _userPhoneNumber;
  String? get getPhoneNumber => _selectedPhoneNumber;
  File? get getImage => _image;
  String? get getScreenshot => _screenshot;
  DoctorModel? get getDoctor => _selectedDoctor;
  String? get getPaymentMethod => _selectedPaymentMethod;
  DateTime? get getSelectedDate => _selectedDate;
  String? get getSelectedSlot => _selectedSlot;
  List<ReservationModel> get getReservations => _reservations;
  int get getTotalReservations => _totalReservations;

  void setIsContainReservations(bool value) {
    _isContainReservations = value;
    notifyListeners();
  }

  void setReservationName(String value) {
    _reservationName = value;
    notifyListeners();
  }

  void setReservationEmail(String value) {
    _reservationEmail = value;
    notifyListeners();
  }

  void setReservationPhoneNumber(String value) {
    _reservationPhoneNumber = value;
    notifyListeners();
  }

  void setProviderName(String value) {
    _providerName = value;
    notifyListeners();
  }

  void setProviderPath(String value) {
    _providerPath = value;
    notifyListeners();
  }

  void setAppPhoneNumber(String? value) {
    appPhoneNumber = value;
    notifyListeners();
  }

  void setIsPayValid(bool? value) {
    _isPayValid = value;
    notifyListeners();
  }

  void setUserPhoneNumber(String value) {
    _userPhoneNumber = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _selectedPhoneNumber = value;
    notifyListeners();
  }

  void setImage(File? value) {
    _image = value;
    notifyListeners();
  }

  void setScreenshot(String value) {
    _screenshot = value;
    notifyListeners();
  }

  void disposeData() {
    _image = null;
    _screenshot = null;
    _userPhoneNumber = null;
    _selectedPhoneNumber = null;
    _isPayValid = null;
    _selectedSlot = null;
    _selectedDate = null;
    notifyListeners();
  }

  void setTotalReservations(int value) {
    _totalReservations = value;
    notifyListeners();
  }

  Future<DoctorModel?> searchForDoctor({required String doctorPhoneNumber}) async {
    return await DoctorsCollection.getDoctorData(uid: doctorPhoneNumber);
  }

  bool handleDoctorDayIndex() {
    List<String> daysData = [];
    int index = _selectedDate!.weekday;
    String day = days[index - 1];
    String startDay = _selectedDoctor!.clinicWorkingFrom;
    String endDay = _selectedDoctor!.clinicWorkingTo;
    int startIndex = days.indexOf(startDay);
    int endIndex = days.indexOf(endDay);

    if (startIndex <= endIndex) {
      for (var i = startIndex; i <= endIndex; i++) {
        daysData.add(days[i]);
      }
    } else {
      for (var i = startIndex; i < days.length; i++) {
        daysData.add(days[i]);
      }
      for (var i = 0; i <= endIndex; i++) {
        daysData.add(days[i]);
      }
    }

    return !daysData.contains(day);
  }

  void initFavourites() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FavouriteCollections.getFavourite(user.uid).listen((snapshot) {
        favourites = snapshot.data()?.favouriteDoctors ?? [];
        notifyListeners();
      });
    }
  }

  void removeData() {
    _selectedDoctor = null;
    _selectedSlot = null;
    _selectedDate = null;
    _selectedPaymentMethod = null;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}