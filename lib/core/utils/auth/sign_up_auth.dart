import 'package:firebase_auth/firebase_auth.dart';
import '/core/constant/shared_preference_key.dart';
import '/core/services/local_storage/shared_preference.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/models/doctors_models/doctor_model.dart';
import '/core/utils/auth/auth_collections.dart';

abstract class SignUpAuth {
  static final _firebase = FirebaseAuth.instance;

  static Future<String?> signUp({
    required String email,
    required String password,
    required String name,
    String? phoneNumber,
    bool isDoctor = false,
  }) async {
    try {
      UserCredential? user = await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.user!.updateDisplayName(name);
      await AuthCollections.insertRole(
        uid: user.user!.uid,
        phoneNumber: phoneNumber,
        role: isDoctor ? "doctor" : "patient",
      ).then(
        (value) {
          return value;
        },
      );
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    return null;
  }

  static Future<String?> doctorSignUp({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String specialist,
    required double price,
    required String country,
    required String state,
    required String city,
    required String description,
    required String street ,
    required String area,
    double? lat,
    double? long,
  }) async {
    try {
      await signUp(
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        name: name,
        isDoctor: true,
      ).then(
        (value) {
          if (value == null) {
            return null;
          }
        },
      );
      var user = _firebase.currentUser!.uid;
      var doctor = DoctorModel(
        street: street,
        uid: user,
        name: name,
        price: price,
        description: description,
        country: country,
        state: state,
        city: city,
        specialist: specialist,
        phoneNumber: phoneNumber,
        rate: 2.5,
        lat: lat,
        long: long,
        area: area,
      );
      await DoctorsCollection.setDoctor(doctor).then(
        (value) {
          if (value == false) {
            return null;
          }
        },
      );
      await SharedPreference.setString(SharedPreferenceKey.role, "doctor");
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (error) {
      return error.toString();
    }
  }
}
