class FavouriteModels {
  final String uid;

  final List<String> favouriteDoctors;

  FavouriteModels({
    required this.uid,
    required this.favouriteDoctors,
  });

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "favouriteDoctors": favouriteDoctors,
    };
  }

  factory FavouriteModels.fromJson(Map<String, dynamic> map) {
    return FavouriteModels(
      uid: map["uid"],
      favouriteDoctors: List<String>.from(
        map["favouriteDoctors"],
      ),
    );
  }
}
