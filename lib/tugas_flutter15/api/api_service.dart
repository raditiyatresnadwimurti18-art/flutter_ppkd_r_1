import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://absensib1.mobileprojp.com";

  static Map<String, String> headers([String? token]) {
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // REGISTER
  static Future register(String name, String email, String password) async {
    var res = await http.post(
      Uri.parse("$baseUrl/api/register"),
      headers: headers(),
      body: jsonEncode({"name": name, "email": email, "password": password}),
    );

    return jsonDecode(res.body);
  }

  // LOGIN
  static Future login(String email, String password) async {
    var res = await http.post(
      Uri.parse("$baseUrl/api/login"),
      headers: headers(),
      body: jsonEncode({"email": email, "password": password}),
    );

    return jsonDecode(res.body);
  }

  // GET PROFILE
  static Future getProfile(String token) async {
    var res = await http.get(
      Uri.parse("$baseUrl/api/user"),
      headers: headers(token),
    );

    return jsonDecode(res.body);
  }

  // UPDATE PROFILE
  static Future updateProfile(String token, String name, String email) async {
    var res = await http.put(
      Uri.parse("$baseUrl/api/user"),
      headers: headers(token),
      body: jsonEncode({"name": name, "email": email}),
    );

    return jsonDecode(res.body);
  }
}
