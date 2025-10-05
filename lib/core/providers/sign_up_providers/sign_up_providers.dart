import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:salamtk/core/services/local_storage/shared_preference.dart';
import 'package:salamtk/models/doctors_models/clinic_data_model.dart';

import '../../functions/security_functions.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/core/utils/storage/doctors_storage.dart';
import '/models/doctors_models/doctor_model.dart';
import '../../constant/shared_preference_key.dart';
import '../../utils/auth/auth_collections.dart';

class SignUpProviders extends ChangeNotifier {
  late LatLng _userLocation;

  String? _workingFrom;

  String? _workingTo;

  Marker? _marker;

  String? _country;

  bool _isHaveSecondClinic = false;

  bool get isHaveSecondClinic => _isHaveSecondClinic;

  void setIsHaveSecondClinic(bool value) {
    _isHaveSecondClinic = value;
    notifyListeners();
  }

  String? _secondClinicCity;
  String? _secondClinicState;
  String? _secondClinicStreet;

  String? get secondClinicCity => _secondClinicCity;

  String? get secondClinicState => _secondClinicState;

  String? get secondClinicStreet => _secondClinicStreet;

  setSecondClinicCity(String? value) {
    _secondClinicCity = value;
    notifyListeners();
  }

  setSecondClinicState(String? value) {
    _secondClinicState = value;
    notifyListeners();
  }

  setSecondClinicStreet(String? value) {
    _secondClinicStreet = value;
    notifyListeners();
  }

  List<String> _selectedSlotsData = [];

  void setSelectedSlotsData(List<String> slots) {
    _selectedSlotsData = slots;
    notifyListeners();
  }

  String? _state;

  String? _city;

  String? _street;
  String? _area;
  String? _specialist;

  Marker? get marker => _marker;
  String? _name;

  String? _description;

  String? _email;

  String? _password;

  String? _phoneNumber;

  File? _image;

  File? _certificate;

  double? _price;

  List<String> get listenSlots => _selectedSlotsData;

  set listenSlots(List<String> slots) {
    _selectedSlotsData = slots;
    notifyListeners();
  }

  final List<String> timeSlots = [
    "12:00 AM",
    "12:30 AM",
    "01:00 AM",
    "01:30 AM",
    "02:00 AM",
    "02:30 AM",
    "03:00 AM",
    "03:30 AM",
    "04:00 AM",
    "04:30 AM",
    "05:00 AM",
    "05:30 AM",
    "06:00 AM",
    "06:30 AM",
    "07:00 AM",
    "07:30 AM",
    "08:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "01:00 PM",
    "01:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
    "06:00 PM",
    "06:30 PM",
    "07:00 PM",
    "07:30 PM",
    "08:00 PM",
    "08:30 PM",
    "09:00 PM",
    "09:30 PM",
    "10:00 PM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM"
  ];

  final List<String> newTimeSlot = [
    "12:00 AM",
    "12:30 AM",
    "01:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "01:00 PM",
    "01:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
    "06:00 PM",
    "06:30 PM",
    "07:00 PM",
    "07:30 PM",
    "08:00 PM",
    "08:30 PM",
    "09:00 PM",
    "09:30 PM",
    "10:00 PM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM"
  ];
  final List<String> days = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
  ];

  String? _clinicWorkingFrom;

  String? _clinicWorkingTo;

  String? _secondSpecialist;

  String? _thirdSpecialist;

  String? get name => _name;

  String? get clinicWorkingFrom => _clinicWorkingFrom;

  String? get clinicWorkingTo => _clinicWorkingTo;

  String? get workingFrom => this._workingFrom;

  String? get workingTo => this._workingTo;

  String? get description => _description;

  String? get email => _email;

  String? get password => _password;

  String? get phoneNumber => _phoneNumber;

  double? get price => _price;

  String? get specialist => _specialist;

  File? get image => _image;

  File? get certificate => _certificate;

  String? _distinctiveMark;

  String? get distinctiveMark => _distinctiveMark;

  void setDistinctiveMark(String value) {
    _distinctiveMark = value;
    notifyListeners();
  }

  String? _selectedCity;
  String? _selectedLocation;

  String get selectedLocation => _selectedLocation ?? "";

  String get selectedCity => _selectedCity ?? "";

  Future<void> uploadImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? selectedImage;

    selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      _image = File(selectedImage.path);
      notifyListeners();
    }
  }

  Future<void> uploadCertificateImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? selectedImage;

    selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      _certificate = File(selectedImage.path);
      notifyListeners();
    }
  }

  void setWorkingFrom(String value) {
    workingToList = [];
    _workingFrom = value;
    int index = timeSlots.indexOf(value);
    for (var i = index + 1; i < timeSlots.length; i++) {
      workingToList.add(timeSlots[i]);
    }
    notifyListeners();
  }

  List<String> workingToList = [];

  void setWorkingTo(String value) {
    _workingTo = value;
    notifyListeners();
  }

  void setDoctorData({
    required String name,
    required String description,
    required String email,
    required String password,
    required String phoneNumber,
    required double price,
    required String specialist,
    required String street,
    String? distinctiveMark,
    String? city,
    String? state,
    String? secondSpecialist,
    String? thirdSpecialist,
  }) {
    _name = name;
    _description = description;
    _email = email;
    _password = password;
    _phoneNumber = phoneNumber;
    _price = price;
    _specialist = specialist;
    _selectedCity = city;
    _selectedLocation = state;
    _street = street;
    _distinctiveMark = distinctiveMark;
    _secondSpecialist = secondSpecialist;
    _thirdSpecialist = thirdSpecialist;
    notifyListeners();
  }

  void resetDoctorData() {
    _name = null;
    _description = null;
    _email = null;
    _password = null;
    _phoneNumber = null;
    _price = null;
    _specialist = null;
    _image = null;
    _certificate = null;
    _marker = null;
    _workingFrom = null;
    _workingTo = null;
    _country = null;
    _state = null;
    _city = null;
    _street = null;

    notifyListeners();
  }

  LatLng get userLocation => _userLocation;

  String? get area => _area;

  String? get country => _country;

  String? get state => _state;

  String? get city => _city;

  String? get street => _street;

  void setClinicWorkingFrom(String value) {
    _clinicWorkingFrom = value;
    notifyListeners();
  }

  void setClinicWorkingTo(String value) {
    _clinicWorkingTo = value;
    notifyListeners();
  }

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController clinicPhoneNumberController = TextEditingController();

  String? _clinicPhoneNumber;

  ClinicDataModel? _secondClinicDataModel;

  ClinicDataModel? get secondClinicDataModel => _secondClinicDataModel;

  void setSecondClinicDataModel(ClinicDataModel value) {
    _secondClinicDataModel = value;
    notifyListeners();
  }

  String? get clinicPhoneNumber => _clinicPhoneNumber;

  void setClinicPhoneNumber(String value) {
    _clinicPhoneNumber = value;
    notifyListeners();
  }

  Future<String?> confirm(
    BuildContext context,
    List<String>? clinicDays, {
    ClinicDataModel? secondClinic,
  }) async {
    try {
      EasyLoading.show();
      _clinicPhoneNumber = clinicPhoneNumberController.text;
      UserCredential? user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      String uid = user.user!.uid;
      user.user?.updateDisplayName(name!);
      await DoctorsStorage.uploadDoctorCertificate(
        certificate: _certificate!,
        doctorId: user.user!.uid,
      );
      await DoctorsStorage.uploadProfileImage(
        profileImage: _image!,
        doctorId: user.user!.uid,
      );
      String certificateUrl = DoctorsStorage.getDoctorCertificateUrl(
        doctorId: user.user!.uid,
      );
      String imageUrl = DoctorsStorage.getDoctorProfileImageUrl(
        doctorId: user.user!.uid,
      );
      user.user?.updatePhotoURL(imageUrl);
      await AuthCollections.insertRole(
        uid: user.user!.uid,
        phoneNumber: phoneNumber,
        role: "doctor",
        hashedPassword: SecurityServices.encryptPassword(password: password!),
      ).then(
        (value) {
          return value;
        },
      );
      await DoctorsCollection.setDoctor(
        DoctorModel(
          distinctiveMark: distinctiveMark,
          clinicWorkingFrom: null,
          clinicWorkingTo: null,
          clinicPhoneNumber: _clinicPhoneNumber!,
          workingFrom: workingFrom,
          workingTo: workingTo,
          certificateUrl: certificateUrl,
          imageUrl: imageUrl,
          area: area ?? "",
          rate: 2.5,
          uid: uid,
          lat: _marker?.point.latitude ?? 0,
          long: _marker?.point.longitude ?? 0,
          street: street ?? "",
          name: name!,
          price: price!,
          description: description!,
          country: country ?? "مصر",
          state: _selectedCity ?? _state ?? "",
          city: _selectedLocation ?? _city ?? "",
          specialist: specialist!,
          phoneNumber: phoneNumber!,
          secondSpecialist: _secondSpecialist,
          thirdSpecialist: _thirdSpecialist,
          days: _selectedSlotsData,
          clinicDays: clinicDays,
          secondClinic: secondClinic,
        ),
      ).then(
        (value) {
          if (value != null) {
            return value;
          }
        },
      );
      await SharedPreference.setString(
        SharedPreferenceKey.role,
        "doctor",
      );
      EasyLoading.dismiss();
      resetDoctorData();
      return null;
    } on FirebaseException catch (error) {
      if (error.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        return ('The account already exists ');
      }
    } catch (error) {
      EasyLoading.dismiss();
      return error.toString();
    }
    return null;
  }
}
