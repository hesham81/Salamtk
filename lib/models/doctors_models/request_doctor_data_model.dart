import 'package:firebase_auth/firebase_auth.dart';

class RequestDoctorModel {
  String requestId;

  final String doctorId;
  String supervisedDoctorId;

  bool accepted;

  RequestDoctorModel({
    this.requestId = "",
    required this.doctorId,
    this.accepted = false,
    this.supervisedDoctorId = "",
  }) {
    requestId = _generateRequestId();
    supervisedDoctorId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestDoctorModel &&
          runtimeType == other.runtimeType &&
          requestId == other.requestId &&
          doctorId == other.doctorId &&
          supervisedDoctorId == other.supervisedDoctorId &&
          accepted == other.accepted;


  factory RequestDoctorModel.fromJson(Map<String, dynamic> json) =>
      RequestDoctorModel(
        requestId: json['id'] as String,
        doctorId: json['uid'] as String,
        accepted: json['status'] as bool,
        supervisedDoctorId: json['supervisedDoctorId'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': requestId,
        'uid': doctorId,
        'status': accepted,
        'supervisedDoctorId': supervisedDoctorId,
      };

  String _generateRequestId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
