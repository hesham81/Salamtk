class PrescriptionModel {
  final String uid;
  DateTime lastUpdate;

  String imageUrl;

  PrescriptionModel({
    required this.uid,
    required this.lastUpdate,
    required this.imageUrl,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      uid: json['uid'],
      lastUpdate: json['lastUpdate'].toDate(),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'lastUpdate': lastUpdate,
      'imageUrl': imageUrl,
    };
  }
}
