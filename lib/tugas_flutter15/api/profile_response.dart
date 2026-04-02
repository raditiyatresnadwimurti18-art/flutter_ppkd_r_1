import 'package:flutter_ppkd_r_1/tugas_flutter15/model/user_model.dart';

class ProfileResponse {
  final UserModel user;

  ProfileResponse({required this.user});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    // Dukungan format dari beberapa API responses
    final maybeData = json['data'];
    final data = maybeData is Map<String, dynamic> ? maybeData : json;

    final userJson = (data['user'] is Map<String, dynamic>)
        ? data['user'] as Map<String, dynamic>
        : data as Map<String, dynamic>?;

    if (userJson == null) {
      throw Exception('Data user tidak ditemukan di response');
    }

    return ProfileResponse(user: UserModel.fromJson(userJson));
  }
}
