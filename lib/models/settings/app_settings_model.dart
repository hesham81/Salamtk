class AppSettingsDataModel {
  String phoneNumber;

  String email;

  String name;

  AppSettingsDataModel({
    required this.phoneNumber,
    required this.email,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsDataModel &&
          runtimeType == other.runtimeType &&
          phoneNumber == other.phoneNumber &&
          email == other.email &&
          name == other.name;

  @override
  int get hashCode => phoneNumber.hashCode ^ email.hashCode ^ name.hashCode;

  factory AppSettingsDataModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsDataModel(
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'email': email,
      'name': name,
    };
  }
}
