class RequestCoins {
  final String uid;

  final double points;

  final String screenShotUrl;

  final String status;

  RequestCoins({
    required this.uid,
    required this.status,
    required this.points,
    required this.screenShotUrl,
  });

  factory RequestCoins.fromMap(Map<String, dynamic> map) {
    return RequestCoins(
      uid: map['uid'],
      points: map['points'],
      screenShotUrl: map['screenShotUrl'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'points': points,
      'screenShotUrl': screenShotUrl,
      'status': status,
    };
  }
}
