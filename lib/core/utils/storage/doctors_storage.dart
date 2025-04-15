import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract class DoctorsStorage {
  static final _supabase = Supabase.instance.client.storage.from("screenshots");

  static Future<String?> uploadDoctorCertificate({
    required File certificate,
    required String doctorId,
  }) async {
    try {
      await _supabase.upload(
        "Certificate/$doctorId",
        certificate,
      );
    } catch (error) {
      return error.toString();
    }
    return null;
  }

  static Future<String?> uploadProfileImage({
    required File profileImage,
    required String doctorId,
  }) async {
    try {
      await _supabase.upload(
        "Profile/$doctorId",
        profileImage,
      );
    } catch (error) {
      return error.toString();
    }
    return null;
  }

  static String getDoctorCertificateUrl({
    required String doctorId,
  }) {
    return _supabase.getPublicUrl(
      "Certificate/$doctorId",
    );
  }

  static String getDoctorProfileImageUrl({
    required String doctorId,
  }) {
    return _supabase.getPublicUrl(
      "Profile/$doctorId",
    );
  }
}
