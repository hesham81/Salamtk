import 'package:equatable/equatable.dart';

class ClinicDataModel extends Equatable {
  // final String clinicId;

  final String clinicStreet;

  final String clinicCity;

  final String clinicZone;
  final String clinicPhone;

  // final String clinicEmail;

  final List<String> clinicDays;

  final List<String> clinicTimeSlots;

  ClinicDataModel({
    // required this.clinicId,
    required this.clinicStreet,
    required this.clinicDays,
    required this.clinicTimeSlots,
    required this.clinicCity,
    required this.clinicZone,
    required this.clinicPhone,
    // required this.clinicEmail,
  });

  factory ClinicDataModel.fromJson(Map<String, dynamic> json) {
    return ClinicDataModel(
      clinicDays:
          (json['clinicDays'] as List).map((e) => e.toString()).toList(),
      clinicTimeSlots:
          (json['clinicTimeSlots'] as List).map((e) => e.toString()).toList(),
      // clinicId: json['clinicId'],
      clinicStreet: json['clinicStreet'],
      clinicCity: json['clinicCity'],
      clinicZone: json['clinicZone'],
      clinicPhone: json['clinicPhone'],
      // clinicEmail: json['clinicEmail'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clinicDays': clinicDays,
      'clinicTimeSlots': clinicTimeSlots,
      // 'clinicId': clinicId,
      'clinicStreet': clinicStreet,
      'clinicCity': clinicCity,
      'clinicZone': clinicZone,
      'clinicPhone': clinicPhone,
      // 'clinicEmail': clinicEmail,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        clinicDays,
        clinicTimeSlots,
        // clinicId,
        clinicStreet,
        clinicCity,
        clinicZone,
        clinicPhone,
        // clinicEmail,
      ];
}
