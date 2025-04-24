import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '/core/utils/doctors/doctors_collection.dart';
import '/models/doctors_models/doctor_model.dart';
import '/models/doctors_models/reviews_models.dart';

abstract class ReviewsCollection {
  static final _firestore = FirebaseFirestore.instance.collection("Reviews");

  static CollectionReference<ReviewsModels> _collectionReference() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) =>
            ReviewsModels.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );

  static Future<void> _updateDoctorsReviews({
    required String doctorId,
  }) async {
    try {
      final Either<ReviewsModels, String> _reviews =
          await getReviews(doctorId: doctorId);
      final DoctorModel? _doctor = await DoctorsCollection.getDoctorData(
        uid: doctorId,
      );
      List<double> _rate = _reviews.fold(
            (l) => l.reviews
                ?.map(
                  (e) => e.rating,
                )
                .toList(),
            (r) => [],
          ) ??
          [];
      int _totalUsers = _reviews.fold(
            (l) => l.reviews?.length ?? 0,
            (r) => 0,
          ) ??
          0;
      double _totalRate = 0;
      for (double rate in _rate) {
        _totalRate += rate;
      }
      double _newRate = _totalRate / _totalUsers;
      _doctor!.rate = _newRate;

      await DoctorsCollection.updateDoctor(_doctor);
    } catch (error) {
      throw Exception(error);
    }
  }

  static Future<ReviewsModels> _defineReview({
    required String doctorId,
  }) async {
    _collectionReference().doc(doctorId).set(
          ReviewsModels(
            doctorId: doctorId,
            reviews: [],
          ),
        );
    ReviewsModels? result;
    await _collectionReference().doc(doctorId).get().then(
          (value) => result = value.data(),
        );
    return result!;
  }

  static Future<String?> addReview({
    required Review review,
    required String doctorId,
  }) async {
    try {
      ReviewsModels? model;
      Either<ReviewsModels, String> result =
          await getReviews(doctorId: doctorId);
      result.fold(
        (success) => model = success,
        (failed) async {
          model = await _defineReview(doctorId: doctorId);
        },
      );
      model!.reviews!.add(review);
      await _collectionReference().doc(doctorId).set(model!);
      await _updateDoctorsReviews(doctorId: doctorId);
      return Future.value(null);
    } catch (error) {
      return Future.value(error.toString());
    }
  }

  static Future<Either<ReviewsModels, String>> getReviews({
    required String doctorId,
  }) async {
    try {
      final snapshot = await _collectionReference().doc(doctorId).get();
      return Left(snapshot.data()!);
    } catch (error) {
      // throw Exception(error);
      return Right(error.toString());
    }
  }

  static Future<Either<bool, String>> deleteReview({
    required String doctorId,
    required Review review,
  }) async {
    try {
      await _collectionReference().doc(doctorId).update({
        "reviews": FieldValue.arrayRemove(
          [
            {
              "patientId": review.patientId,
            }
          ],
        ),
      });
      return Left(true);
    } catch (error) {
      return Right(error.toString());
    }
  }

  static Future<Either<List<Review>, String>> getMyReviews({
    required String patientId,
  }) async {
    try {
      final List<ReviewsModels?> allReviewsData =
          await _collectionReference().get().then(
                (value) => value.docs
                    .map(
                      (e) => e.data(),
                    )
                    .toList(),
              );
      List<Review> allReviews = [];
      for (ReviewsModels? review in allReviewsData) {
        for (int i = 0; i < review!.reviews!.length; i++) {
          if (review.reviews![i].patientId == patientId) {
            allReviews.add(review.reviews![i]);
          }
        }
      }

      return Left(allReviews);
    } catch (error) {
      return Right(error.toString());
    }
  }
}
