import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreference {
  // Singleton instance of SharedPreferences
  static final Future<SharedPreferences> _sharedPreference = SharedPreferences.getInstance();

  /// Saves a String value to SharedPreferences.
  static Future<void> setString(String key, String value) async {
    final prefs = await _sharedPreference;
    await prefs.setString(key, value);
  }

  /// Retrieves a String value from SharedPreferences.
  static Future<String?> getString(String key) async {
    final prefs = await _sharedPreference;
    return prefs.getString(key);
  }

  /// Removes a specific key-value pair from SharedPreferences.
  static Future<void> remove(String key) async {
    final prefs = await _sharedPreference;
    await prefs.remove(key);
  }

  /// Clears all data stored in SharedPreferences.
  static Future<void> clearAll() async {
    final prefs = await _sharedPreference;
    await prefs.clear();
  }
}