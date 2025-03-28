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
      uid: json['uid'] ?? 'default_uid',
      lastUpdate: json['lastUpdate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['lastUpdate'] as int)
          : DateTime.now(),
      imageUrl: json['imageUrl'] ??
          'default_image_url',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'lastUpdate': lastUpdate.millisecondsSinceEpoch,
      'imageUrl': imageUrl,
    };
  }
}
