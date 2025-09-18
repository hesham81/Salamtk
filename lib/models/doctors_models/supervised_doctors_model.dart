class SupervisedDoctorsModel {
  String id;

  double totalMoney;
  List<String> doctors;

  SupervisedDoctorsModel({
    required this.id,
    required this.totalMoney,
    required this.doctors,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupervisedDoctorsModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory SupervisedDoctorsModel.fromJson(Map<String, dynamic> json) =>
      SupervisedDoctorsModel(
        id: json["id"] as String,
        totalMoney: json["totalMoney"] as double,
        doctors: json["doctors"] as List<String>,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalMoney": totalMoney,
        "doctors": doctors,
      };
}
