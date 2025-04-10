class PrescriptionModel {
  final String uid;
  DateTime lastUpdate;

  List<String> prescriptions;
  List<String> analysis;
  List<String> rumor;

  PrescriptionModel({
    required this.uid,
    required this.lastUpdate,
    required this.prescriptions,
    required this.analysis,
    required this.rumor,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionModel(
      uid: json['uid'] ?? 'default_uid',
      lastUpdate: json['lastUpdate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['lastUpdate'] as int)
          : DateTime.now(),
      prescriptions: List<String>.from(json['prescriptions'] ?? []),
      analysis: List<String>.from(json['analysis'] ?? []),
      rumor: List<String>.from(json['rumor'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'lastUpdate': lastUpdate.millisecondsSinceEpoch,
      'prescriptions': prescriptions,
      'analysis': analysis,
      'rumor': rumor,
    };
  }
}