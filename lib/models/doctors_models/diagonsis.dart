class DiagonsisModel {
  String id;

  final String diagonsis;

  final String patientId;

  final String doctorId;

  final DateTime date;
  String? imageUrl;

  DiagonsisModel({
    required this.id,
    required this.diagonsis,
    required this.patientId,
    required this.doctorId,
    required this.date,
    this.imageUrl,
  });

  factory DiagonsisModel.fromJson(Map<String, dynamic> json) => DiagonsisModel(
        id: json["id"],
        diagonsis: json["diagonsis"],
        patientId: json["patientId"],
        doctorId: json["doctorId"],
        date: DateTime.parse(json["date"]),
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "diagonsis": diagonsis,
        "patientId": patientId,
        "doctorId": doctorId,
        "date": date.toIso8601String(),
        "imageUrl": imageUrl,
      };
}
