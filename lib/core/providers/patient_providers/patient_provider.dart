import 'package:flutter/cupertino.dart';
import '/models/doctors_models/doctor_model.dart';

class PatientProvider extends ChangeNotifier {
  DoctorModel? selectedDoctor;

  //setters

  void setSelectedDoctor(DoctorModel doctorModel) {
    selectedDoctor = doctorModel;
    notifyListeners();
  }

  void clearSelectedDoctor() {
    selectedDoctor = null;
    notifyListeners();
  }

  //getter

  bool get isDoctorSelected => selectedDoctor != null ? true : false;

  DoctorModel? get getDoctor => selectedDoctor;
}
