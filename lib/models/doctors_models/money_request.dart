class MoneyRequest {
  final String doctorId;

  final DateTime date;

  final double amount;

  String status;

  String? screenShot;

  MoneyRequest({
    required this.doctorId,
    required this.date,
    required this.amount,
    this.status = "Pending",
    this.screenShot,
  });

  factory MoneyRequest.fromJson(Map<String, dynamic> json) {
    return MoneyRequest(
      doctorId: json['doctorId'],
      date: DateTime.parse(json['date']),
      amount: json['amount'],
      status: json['status'],
      screenShot: json['screenShot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'date': date.toIso8601String(),
      'amount': amount,
      'status': status,
      'screenShot': screenShot,
    };
  }
}
