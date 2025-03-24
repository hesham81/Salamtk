class ReservationModel {
   String reservationId;

  final String uid;

  final String doctorId;

  final DateTime date;

  final String slot;

  final double price;

  final String paymentMethod;

  final String email;

  ReservationModel({
    required this.reservationId,
    required this.uid,
    required this.doctorId,
    required this.date,
    required this.slot,
    required this.price,
    required this.paymentMethod,
    required this.email,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      reservationId: json['reservationId'],
      uid: json['uid'],
      doctorId: json['doctorId'],
      date: DateTime.parse(json['date']),
      slot: json['slot'],
      price: json['price'],
      paymentMethod: json['paymentMethod'],
      email: json['email'],
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
    };
  }
}
