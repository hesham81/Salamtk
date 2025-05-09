class RequestDoctorModel {
  String requestId;

  final String doctorId;

  bool accepted;

  RequestDoctorModel({
    this.requestId = "",
    required this.doctorId,
    this.accepted = false,
  }) {
    requestId = _generateRequestId();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestDoctorModel &&
          runtimeType == other.runtimeType &&
          requestId == other.requestId &&
          doctorId == other.doctorId &&
          accepted == other.accepted;

  factory RequestDoctorModel.fromJson(Map<String, dynamic> json) =>
      RequestDoctorModel(
        requestId: json['id'] as String,
        doctorId: json['uid'] as String,
        accepted: json['status'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'id': requestId,
        'uid': doctorId,
        'status': accepted,
      };

  String _generateRequestId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
