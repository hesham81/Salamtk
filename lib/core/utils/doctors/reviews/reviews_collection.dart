import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '/models/doctors_models/reviews_models.dart';

abstract class ReviewsCollection {
  static final _firestore = FirebaseFirestore.instance.collection("Reviews");

  static CollectionReference<ReviewsModels> _collectionReference() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) =>
            ReviewsModels.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );

  static Future<String?> addReview({
    required ReviewsModels model,
  }) async {
    try {
      await _collectionReference().doc(model.doctorId).set(model);
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
      return Right(error.toString());
    }
  }

  static Future<Either<bool, String>> deleteReview({
    required String doctorId,
    required String userId,
  }) async {
    try {
      await _collectionReference().doc(doctorId).update({
        "reviews": FieldValue.arrayRemove(
          [
            {
              "userId": userId,
            }
          ],
        ),
      });
      return Left(true);
    } catch (error) {
      return Right(error.toString());
    }
  }
}
