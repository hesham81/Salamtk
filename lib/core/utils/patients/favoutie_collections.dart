import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/patients_models/favourite_models.dart';

abstract class FavouriteCollections {
  static final _firestore = FirebaseFirestore.instance.collection("Favourite");

  static CollectionReference<FavouriteModels> _collectionReference() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) =>
            FavouriteModels.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
      );

  static Future<void> updateFavourite(FavouriteModels favouriteModels) async {
    await _collectionReference().doc(favouriteModels.uid).set(favouriteModels);
  }

  static Stream<DocumentSnapshot<FavouriteModels>> getFavourite(String uid) {
    return _collectionReference().doc(uid).snapshots();
  }

  static Future<FavouriteModels> getFavouriteData({required String uid}) async {
    bool isExists = await checkIfExists(uid);
    if (!isExists) {
      await updateFavourite(
        FavouriteModels(
          uid: uid,
          favouriteDoctors: [],
        ),
      );
    }
    var res = await _collectionReference().doc(uid).get();
    return res.data()!;
  }

  static Future<bool> checkIfExists(String uid) async {
    try {
      final result = await _collectionReference().doc(uid).get();
      return result.exists;
    } catch (e) {
      return false;
    }
  }

  static Future<void> deleteFavourite({
    required String uid,
    required String doctorId,
  }) async {
    await _collectionReference().doc(uid).update({
      "favouriteDoctors": FieldValue.arrayRemove([doctorId])
    });
  }

  static Future<void> addFavourite({
    required String uid,
    required String doctorId,
  }) async {
    await _collectionReference().doc(uid).update({
      "favouriteDoctors": FieldValue.arrayUnion([doctorId])
    });
  }
}
