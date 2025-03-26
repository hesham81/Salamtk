import 'package:firebase_auth/firebase_auth.dart';
import 'package:twseef/core/utils/doctors/doctors_collection.dart';
import 'package:twseef/models/doctors_models/doctor_model.dart';
import '/core/utils/auth/auth_collections.dart';

abstract class SignUpAuth {
  static final _firebase = FirebaseAuth.instance;

  static Future<String?> signUp({
    required String email,
    required String password,
    required String name,
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
        role: isDoctor ? "doctor" : "patient",
      ).then(
        (value) {
          return value;
        },
      );
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
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
  }) async {
    try {
      await signUp(
        email: email,
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
      var doctor = DoctorModel(
        name: name,
        price: price,
        description: description,
        country: country,
        state: state,
        city: city,
        specialist: specialist,
        phoneNumber: phoneNumber,
      );
      await DoctorsCollection.setDoctor(doctor).then(
        (value) {
          if (value == false) {
            return null;
          }
        },
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (error) {
      return error.toString();
    }
  }
}
