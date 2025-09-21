class RequestCoins {
  final String uid;

  final double points;

   String? screenShotUrl;

  final String status;

  final String phoneNumber ;

  RequestCoins({
    required this.phoneNumber,
    required this.uid,
    required this.status,
    required this.points,
    required this.screenShotUrl,
  });

  factory RequestCoins.fromMap(Map<String, dynamic> map) {
    return RequestCoins(
      phoneNumber: map['phoneNumber'],
      uid: map['uid'],
      points: map['points'],
      screenShotUrl: map['screenShotUrl'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'uid': uid,
      'points': points,
      'screenShotUrl': screenShotUrl,
      'status': status,
    };
  }
}
