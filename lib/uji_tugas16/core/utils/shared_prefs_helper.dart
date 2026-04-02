import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class SharedPrefsHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance {
    if (_prefs == null) {
      throw Exception('SharedPrefs not initialized. Call init() first.');
    }
    return _prefs!;
  }

  // Token
  static Future<void> saveToken(String token) async {
    await instance.setString(AppConstants.tokenKey, token);
  }

  static String? getToken() {
    return instance.getString(AppConstants.tokenKey);
  }

  static Future<void> removeToken() async {
    await instance.remove(AppConstants.tokenKey);
  }

  static bool isLoggedIn() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  // Theme Mode
  static Future<void> saveThemeMode(bool isDark) async {
    await instance.setBool(AppConstants.themeModeKey, isDark);
  }

  static bool? getThemeMode() {
    return instance.getBool(AppConstants.themeModeKey);
  }

  // Clear all
  static Future<void> clearAll() async {
    await instance.clear();
  }
}
