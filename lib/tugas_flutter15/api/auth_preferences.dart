import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthPreferences {
  static const String _tokenKey = "TOKEN";
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // SIMPAN TOKEN
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // AMBIL TOKEN
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // HAPUS TOKEN (LOGOUT)
  static Future<void> removeToken() async {
    await _storage.delete(key: _tokenKey);
  }

  // CEK APAKAH SUDAH LOGIN
  static Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: _tokenKey);
    return token != null && token.isNotEmpty;
  }
}