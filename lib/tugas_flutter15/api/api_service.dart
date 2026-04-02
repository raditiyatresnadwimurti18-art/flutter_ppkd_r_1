import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://absensib1.mobileprojp.com";
  static const Duration _timeout = Duration(seconds: 15);

  static Map<String, String> headers([String? token]) {
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // Helper: decode response dengan status check
  static Map<String, dynamic> _handleResponse(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    }

    // Coba ambil pesan error dari body
    try {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      final message = body['message'] ?? 'Terjadi kesalahan server';
      throw Exception(message);
    } catch (_) {
      throw Exception('HTTP ${res.statusCode}: Server error');
    }
  }

  // =========================
  // REGISTER
  // =========================
  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final res = await http
          .post(
            Uri.parse("$baseUrl/api/register"),
            headers: headers(),
            body: jsonEncode({
              "name": name,
              "email": email,
              "password": password,
            }),
          )
          .timeout(_timeout);

      return _handleResponse(res);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet');
    } on TimeoutException {
      throw Exception('Koneksi timeout, coba lagi');
    }
  }

  // =========================
  // LOGIN
  // =========================
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final res = await http
          .post(
            Uri.parse("$baseUrl/api/login"),
            headers: headers(),
            body: jsonEncode({"email": email, "password": password}),
          )
          .timeout(_timeout);

      return _handleResponse(res);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet');
    } on TimeoutException {
      throw Exception('Koneksi timeout, coba lagi');
    }
  }

  // =========================
  // GET PROFILE
  // =========================
  static Future<Map<String, dynamic>> getProfile(String token) async {
    const profilePaths = ['/api/user', '/api/profile', '/api/auth/me'];

    try {
      for (final path in profilePaths) {
        final res = await http
            .get(Uri.parse('$baseUrl$path'), headers: headers(token))
            .timeout(_timeout);

        if (res.statusCode == 404) {
          // Coba endpoint lain jika path pertama tidak tersedia
          continue;
        }

        return _handleResponse(res);
      }

      throw Exception('Profil endpoint tidak ditemukan (404)');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet');
    } on TimeoutException {
      throw Exception('Koneksi timeout, coba lagi');
    }
  }

  // =========================
  // UPDATE PROFILE
  // =========================
  static Future<Map<String, dynamic>> updateProfile(
    String token,
    String name,
    String email,
  ) async {
    const profilePaths = ['/api/user', '/api/profile', '/api/auth/me'];

    try {
      for (final path in profilePaths) {
        final res = await http
            .put(
              Uri.parse('$baseUrl$path'),
              headers: headers(token),
              body: jsonEncode({'name': name, 'email': email}),
            )
            .timeout(_timeout);

        if (res.statusCode == 404) {
          continue;
        }

        return _handleResponse(res);
      }

      throw Exception('Profil endpoint tidak ditemukan (404)');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet');
    } on TimeoutException {
      throw Exception('Koneksi timeout, coba lagi');
    }
  }
}
