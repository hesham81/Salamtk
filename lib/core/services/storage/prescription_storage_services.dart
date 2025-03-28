import 'dart:io';
// import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PrescriptionStorageServices {
  static final _supabase = Supabase.instance.client.storage.from("images");

  static Future<String?> uploadPrescription(String path, File fileName) async {
    try {
      await _supabase.upload(path, fileName);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> getUrl(String path) async {
    try {
      final url = await _supabase.getPublicUrl(path);
      return url;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<bool> checkIfExists(String path) async {
    try {
      final result = await _supabase.list(path: path);
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> deleteFile(String path) async {
    try {
      await _supabase.remove([path]);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> updateFile(String path, File fileName) async {
    try {
      await _supabase.update(path, fileName);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // static Future<Uint8List?> downloadFile(String path) async {
  //   try {
  //     final response = await _supabase.download(path);
  //     return response.;
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
