import 'dart:convert';
import 'dart:io';
import 'package:flutter_ppkd_r_1/uji_tugas16/core/constants/app_constants.dart';
import 'package:flutter_ppkd_r_1/uji_tugas16/core/utils/shared_prefs_helper.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final String _baseUrl = AppConstants.baseUrl;
  final Duration _timeout = const Duration(seconds: 30);

  Map<String, String> _headers({bool withAuth = false}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (withAuth) {
      final token = SharedPrefsHelper.getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  Future<Map<String, dynamic>> get(
    String endpoint, {
    bool withAuth = true,
    Map<String, String>? queryParams,
  }) async {
    try {
      Uri uri = Uri.parse('$_baseUrl$endpoint');
      if (queryParams != null && queryParams.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParams);
      }

      final response = await http
          .get(uri, headers: _headers(withAuth: withAuth))
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet.');
    } on HttpException {
      throw Exception('Terjadi kesalahan pada server.');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool withAuth = false,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await http
          .post(
            uri,
            headers: _headers(withAuth: withAuth),
            body: json.encode(body),
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet.');
    } on HttpException {
      throw Exception('Terjadi kesalahan pada server.');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body, {
    bool withAuth = true,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');
      final response = await http
          .put(
            uri,
            headers: _headers(withAuth: withAuth),
            body: json.encode(body),
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet.');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    bool withAuth = true,
    Map<String, String>? queryParams,
  }) async {
    try {
      Uri uri = Uri.parse('$_baseUrl$endpoint');
      if (queryParams != null && queryParams.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParams);
      }

      final response = await http
          .delete(uri, headers: _headers(withAuth: withAuth))
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw Exception('Tidak ada koneksi internet.');
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final decoded = json.decode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    } else if (response.statusCode == 401) {
      throw Exception('Sesi habis. Silakan login kembali.');
    } else if (response.statusCode == 422) {
      // Validation errors
      final errors =
          decoded['errors'] ?? decoded['message'] ?? 'Validasi gagal';
      if (errors is Map) {
        final firstError = (errors as Map).values.first;
        if (firstError is List) throw Exception(firstError.first);
        throw Exception(firstError.toString());
      }
      throw Exception(errors.toString());
    } else {
      final msg =
          decoded['message'] ?? 'Terjadi kesalahan (${response.statusCode})';
      throw Exception(msg);
    }
  }
}
