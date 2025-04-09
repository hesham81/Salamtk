import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ScreenShotsStorageManager {
  static final _supabase = Supabase.instance.client.storage.from("screenshots");

  static Future<String?> uploadScreenShot({
    required String uid,
    required String fileName,
    required File file,
  }) async {
    try {
      await _supabase.upload(
        "${uid}/${fileName}",
        file,
        fileOptions: const FileOptions(upsert: true),
      );
      return null;
    } catch (error) {
      return error.toString();
    }
  }

  static Future<String?> getScreenShotUrl({
    required String uid,
    required String fileName,
  }) async {
    try {
      var res = await _supabase.getPublicUrl("${uid}/${fileName}");
      return res;
    } catch (error) {
      return null;
    }
  }
}
