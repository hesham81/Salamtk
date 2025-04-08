import 'package:firebase_auth/firebase_auth.dart';
import '/core/utils/patients/favoutie_collections.dart';
import '/models/patients_models/favourite_models.dart';

class Favourite {
  static FavouriteModels? _fav;

  Future<void> _init() async {
    User? uid = await FirebaseAuth.instance.currentUser;
    _fav = await FavouriteCollections.getFavouriteData(uid: uid!.uid).then(
      (value) => value,
    );
  }

  Favourite.init() {
    Future.wait(
      [
        _init(),
      ],
    );
  }

  Future<bool?> checkIfDoctorIsLikedOrNot({
    required String doctorId,
  }) async {
    try {
      for (var item in _fav!.favouriteDoctors) {
        if (item == doctorId) {
          return Future.value(true);
        }
      }
      return Future.value(false);
    } catch (error) {
      return null;
    }
  }

  Future<void> updateFavourite(FavouriteModels favouriteModels) async {
    await FavouriteCollections.updateFavourite(favouriteModels);
  }
}
