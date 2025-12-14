import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/doctors_models/doctor_model.dart';

abstract class DoctorsCollection {
  static final _firestore = FirebaseFirestore.instance.collection("doctor");

  static Stream<QuerySnapshot<DoctorModel>> getDoctors() =>
      _collectionReference().snapshots();

  static CollectionReference<DoctorModel> _collectionReference() {
    return _firestore.withConverter<DoctorModel>(
      fromFirestore: (snapshot, _) => DoctorModel.fromJson(snapshot.data()!),
      toFirestore: (doctor, _) => doctor.toJson(),
    );
  }

  static Future<String?> setDoctor(DoctorModel doctor) async {
    try {
      await _collectionReference().doc(doctor.uid).set(doctor);
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  static Future<DoctorModel?> getDoctorData({
    required String uid,
  }) async {
    try {
      var res = await _collectionReference()
          .where(
            "uid",
            isEqualTo: uid,
          )
          .get();
      return res.docs.first.data();
    } catch (error) {
      return null;
    }
  }

  static Future<List<DoctorModel>?> getListOfDoctors({
    required String phoneNumber,
  }) async {
    try {
      var res = await _collectionReference().where(
        "uid",
        isEqualTo: phoneNumber,
      );
      return res
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
    } catch (error) {
      return null;
    }
  }

  static Future<bool> updateDoctor(DoctorModel doctor) async {
    try {
      doctor.isInTheClinic = !doctor.isInTheClinic;
      await _collectionReference().doc(doctor.uid).set(doctor);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<List<DoctorModel>> doctors() async {
    try {
      // Get the first snapshot from the stream
      final querySnapshot = await DoctorsCollection.getDoctors().first;

      // Map the documents to DoctorModel objects
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (error) {
      // Log the error and rethrow it
      print('Error fetching doctors: $error');
      rethrow;
    }
  }

  static Future<DoctorModel> searchForDoctorUsingDoctorId({
    required String doctorId,
  }) async {
    var res = await _collectionReference().doc(doctorId).get();
    return res.data()!;
  }

  static Future<void> acceptAllDoctors() async {
    List<DoctorModel> doctors = await _collectionReference().get().then(
          (value) => value.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
    for (DoctorModel doctor in doctors) {
      doctor.isVerified = true;
      await _collectionReference().doc(doctor.uid).set(doctor);
    }
  }

  static String _getTheTranslateOfTheDays(String day) {
    // توحيد المدخل: إزالة المسافات الزائدة وتحويل إلى صيغة موحدة (بدون تشكيل، وحروف عادية)
    String normalizedDay = day
        .trim()
        .replaceAll(RegExp(r'[ًٌٍَُِّْـ]'), ''); // إزالة التشكيل إن وُجد

    switch (normalizedDay) {
      case "الاثنين":
      case "اثنين":
        return "Monday";
      case "الثلاثاء":
      case "ثلاثاء":
        return "Tuesday";
      case "الأربعاء":
      case "اربعاء":
      case "الاربعاء":
        return "Wednesday";
      case "الخميس":
      case "خميس":
        return "Thursday";
      case "الجمعة":
      case "جمعه":
      case "جمعة":
        return "Friday";
      case "السبت":
      case "سبت":
        return "Saturday";
      case "الأحد":
      case "احد":
      case "الاحد":
        return "Sunday";
      default:
        return "Error";
    }
  }

  static DoctorModel _changeDates({
    required DoctorModel doctor,
  }) {
    List<String> days = [];

    for (var day in doctor.clinicDays!)
      days.add(_getTheTranslateOfTheDays(day));

    doctor.clinicDays = days;

    if (doctor.secondClinic != null) {
      List<String> secondDays = [];

      for (var day in doctor.clinicDays!)
        secondDays.add(_getTheTranslateOfTheDays(day));
      doctor.secondClinic!.clinicDays = secondDays;
    }
    return doctor;
  }

  static Future<void> changeTheDates() async {
    List<DoctorModel> doctors = await _collectionReference().get().then(
          (value) => value.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
    for (DoctorModel doctor in doctors) {
      await _collectionReference().doc(doctor.uid).set(
            _changeDates(doctor: doctor),
          );
    }
  }

// static Future<bool> updateSecondClinicData({required ClinicDataModel clinic})
}

// abstract class DoctorsCollectionBackup {
//   static final _firestore = FirebaseFirestore.instance.collection("doctor");
//
//   static Stream<QuerySnapshot<DoctorModel>> getDoctors() =>
//       _collectionReference().snapshots();
//
//   static CollectionReference<DoctorModel> _collectionReference() {
//     return _firestore.withConverter<DoctorModel>(
//       fromFirestore: (snapshot, _) => DoctorModel.fromJson(snapshot.data()!),
//       toFirestore: (doctor, _) => doctor.toJson(),
//     );
//   }
//
//   static Future<String?> setDoctor(DoctorModel doctor) async {
//     try {
//       await _collectionReference().doc(doctor.uid).set(doctor);
//       return null;
//     } catch (error) {
//       return error.toString();
//     }
//   }
//
//   static Future<String?> backup() async {
//     try {
//       var doctors = await DoctorsCollection.doctors();
//       for(var doctor in doctors )
//         await setDoctor(doctor);
//
//       return null;
//     } catch (error) {
//       return error.toString();
//     }
//   }
//
//   static Future<DoctorModel?> getDoctorData({
//     required String uid,
//   }) async {
//     try {
//       var res = await _collectionReference()
//           .where(
//         "uid",
//         isEqualTo: uid,
//       )
//           .get();
//       return res.docs.first.data();
//     } catch (error) {
//       return null;
//     }
//   }
//
//   static Future<List<DoctorModel>?> getListOfDoctors({
//     required String phoneNumber,
//   }) async {
//     try {
//       var res = await _collectionReference().where(
//         "uid",
//         isEqualTo: phoneNumber,
//       );
//       return res
//           .get()
//           .then((value) => value.docs.map((e) => e.data()).toList());
//     } catch (error) {
//       return null;
//     }
//   }
//
//   static Future<bool> updateDoctor(DoctorModel doctor) async {
//     try {
//       doctor.isInTheClinic = !doctor.isInTheClinic;
//       await _collectionReference().doc(doctor.uid).set(doctor);
//       return true;
//     } catch (error) {
//       return false;
//     }
//   }
//
//   static Future<List<DoctorModel>> doctors() async {
//     try {
//       // Get the first snapshot from the stream
//       final querySnapshot = await DoctorsCollection.getDoctors().first;
//
//       // Map the documents to DoctorModel objects
//       return querySnapshot.docs.map((doc) => doc.data()).toList();
//     } catch (error) {
//       // Log the error and rethrow it
//       print('Error fetching doctors: $error');
//       rethrow;
//     }
//   }
//
//   static Future<DoctorModel> searchForDoctorUsingDoctorId({
//     required String doctorId,
//   }) async {
//     var res = await _collectionReference().doc(doctorId).get();
//     return res.data()!;
//   }
//
//   static Future<void> acceptAllDoctors() async {
//     List<DoctorModel> doctors = await _collectionReference().get().then(
//           (value) => value.docs
//           .map(
//             (e) => e.data(),
//       )
//           .toList(),
//     );
//     for (DoctorModel doctor in doctors) {
//       doctor.isVerified = true;
//       await _collectionReference().doc(doctor.uid).set(doctor);
//     }
//   }
//
//   static String _getTheTranslateOfTheDays(String day) {
//     // توحيد المدخل: إزالة المسافات الزائدة وتحويل إلى صيغة موحدة (بدون تشكيل، وحروف عادية)
//     String normalizedDay = day
//         .trim()
//         .replaceAll(RegExp(r'[ًٌٍَُِّْـ]'), ''); // إزالة التشكيل إن وُجد
//
//     switch (normalizedDay) {
//       case "الاثنين":
//       case "اثنين":
//         return "Monday";
//       case "الثلاثاء":
//       case "ثلاثاء":
//         return "Tuesday";
//       case "الأربعاء":
//       case "اربعاء":
//       case "الاربعاء":
//         return "Wednesday";
//       case "الخميس":
//       case "خميس":
//         return "Thursday";
//       case "الجمعة":
//       case "جمعه":
//       case "جمعة":
//         return "Friday";
//       case "السبت":
//       case "سبت":
//         return "Saturday";
//       case "الأحد":
//       case "احد":
//       case "الاحد":
//         return "Sunday";
//       default:
//         return "Error";
//     }
//   }
//
//   static DoctorModel _changeDates({
//     required DoctorModel doctor,
//   }) {
//     List<String> days = [];
//
//     for (var day in doctor.clinicDays!)
//       days.add(_getTheTranslateOfTheDays(day));
//
//     doctor.clinicDays = days;
//
//     if (doctor.secondClinic != null) {
//       List<String> secondDays = [];
//
//       for (var day in doctor.clinicDays!)
//         secondDays.add(_getTheTranslateOfTheDays(day));
//       doctor.secondClinic!.clinicDays = secondDays;
//     }
//     return doctor;
//   }
//
//   static Future<void> changeTheDates() async {
//     List<DoctorModel> doctors = await _collectionReference().get().then(
//           (value) => value.docs
//           .map(
//             (e) => e.data(),
//       )
//           .toList(),
//     );
//     for (DoctorModel doctor in doctors) {
//       await _collectionReference().doc(doctor.uid).set(
//         _changeDates(doctor: doctor),
//       );
//     }
//   }
//
// // static Future<bool> updateSecondClinicData({required ClinicDataModel clinic})
// }
