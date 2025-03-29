import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PrescriptionStorageServices {
  static final _supabase = Supabase.instance.client.storage.from("images");

  static Future<String?> uploadPrescription(String path, File fileName) async {
    try {
      await checkIfExists(path).then(
        (value) async {
          if (value) {
            await deleteFile(path);
          }
        },
      );
      await _supabase.upload(path, fileName,
          fileOptions: const FileOptions(upsert: true), retryAttempts: 3);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  static String getUrl(String path) {
    try {
      final url = _supabase.getPublicUrl(path);
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
      print("Removing The File ");
      await _supabase.remove(
        [path],
      );
      print("The File Removed");
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> updateFile(String path, File fileName) async {
    try {
      await _supabase.update(
        path,
        fileName,
        fileOptions: const FileOptions(upsert: true),
      );
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
