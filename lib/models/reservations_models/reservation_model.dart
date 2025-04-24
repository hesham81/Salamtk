class ReservationModel {
  String reservationId;

  final String uid;

  final String doctorId;

  final DateTime date;

  final String slot;

  final String patientName;

  final double price;

  final String paymentMethod;

  final String email;

  final String patientPhoneNumber;

  final String screenshotUrl;

  final String cashedPhoneNumber;

  final String selectedPhoneNumber;

  String status;

   ReservationModel({
    required this.cashedPhoneNumber,
    required this.selectedPhoneNumber,
    required this.screenshotUrl,
    required this.patientPhoneNumber,
    required this.reservationId,
    required this.uid,
    required this.doctorId,
    required this.date,
    required this.slot,
    required this.price,
    required this.paymentMethod,
    required this.email,
    required this.patientName,
    this.status = "Pending",
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      patientName: json['patientName'],
      reservationId: json['reservationId'],
      uid: json['uid'],
      doctorId: json['doctorId'],
      date: DateTime.parse(json['date']),
      slot: json['slot'],
      price: json['price'],
      paymentMethod: json['paymentMethod'],
      email: json['email'],
      patientPhoneNumber: json['patientPhoneNumber'],
      status: json['status'],
      screenshotUrl: json['screenshotUrl'],
      cashedPhoneNumber: json['cashedPhoneNumber'],
      selectedPhoneNumber: json['selectedPhoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reservationId': reservationId,
      'uid': uid,
      'doctorId': doctorId,
      'date': date.toIso8601String(),
      'slot': slot,
      'price': price,
      'paymentMethod': paymentMethod,
      'email': email,
      'patientPhoneNumber': patientPhoneNumber,
      'patientName': patientName,
      'status': status,
      'screenshotUrl': screenshotUrl,
      'cashedPhoneNumber': cashedPhoneNumber,
      'selectedPhoneNumber': selectedPhoneNumber,
    };
  }
}
