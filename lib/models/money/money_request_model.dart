import 'dart:math';

class MoneyRequestModel {
  final String doctorId;

  final String phoneNumber;

  final double amount;

  final DateTime date;

  String status;

  final isVerified;
  String? screenShot;
  String requestId;

  MoneyRequestModel({
    required this.doctorId,
    required this.phoneNumber,
    required this.amount,
    required this.date,
    this.status = "Pending",
    required this.isVerified,
    this.screenShot,
    required this.requestId,
  }) {
    _generateId(
      phoneNumber: phoneNumber,
      dateTime: "${date.year} ${date.month} ${date.day}",
      doctorId: doctorId,
    );
  }

  factory MoneyRequestModel.fromJson(Map<String, dynamic> json) =>
      MoneyRequestModel(
        doctorId: json['doctorId'],
        phoneNumber: json['phoneNumber'],
        amount: json['amount'],
        date: DateTime.fromMillisecondsSinceEpoch(json['date']),
        status: json['status'],
        isVerified: json['isVerified'],
        screenShot: json['screenShot'],
        requestId: json['requestId'],
      );

  Map<String, dynamic> toJson() => {
        'doctorId': doctorId,
        'phoneNumber': phoneNumber,
        'amount': amount,
        'date': date.millisecondsSinceEpoch,
        'status': status,
        'isVerified': isVerified,
        'screenShot': screenShot,
        'requestId': requestId,
      };

  _generateId({
    required String phoneNumber,
    required String dateTime,
    required String doctorId,
  }) {
    var randomNumber = Random().nextInt(1000000);
    this.requestId =
        "$phoneNumber$dateTime$doctorId${randomNumber.toString()}";
  }
}
