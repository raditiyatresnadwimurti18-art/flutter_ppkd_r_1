import '../models/api_response.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/shared_prefs_helper.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  /// Fetch list of trainings for registration dropdown
  Future<List<TrainingModel>> getTrainings() async {
    final response = await _apiService.get(
      AppConstants.trainingEndpoint,
      withAuth: false,
    );

    final List<dynamic> data =
        response['data'] ?? response['trainings'] ?? response as dynamic ?? [];
    if (data is List) {
      return data.map((e) => TrainingModel.fromJson(e)).toList();
    }
    return [];
  }

  /// Register new user
  Future<ApiResponse<UserModel>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String batch,
    required int trainingId,
  }) async {
    final response = await _apiService.post(AppConstants.registerEndpoint, {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'batch': batch,
      'training_id': trainingId,
    }, withAuth: false);

    final token =
        response['token'] ??
        response['access_token'] ??
        response['data']?['token'];
    final userData = response['data']?['user'] ?? response['data'];

    UserModel? user;
    if (userData != null && userData is Map<String, dynamic>) {
      user = UserModel.fromJson(userData);
    }

    if (token != null) {
      await SharedPrefsHelper.saveToken(token);
    }

    return ApiResponse<UserModel>(
      success: true,
      message: response['message'] ?? 'Registrasi berhasil',
      data: user,
      token: token,
    );
  }

  /// Login existing user
  Future<ApiResponse<UserModel>> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiService.post(AppConstants.loginEndpoint, {
      'email': email,
      'password': password,
    }, withAuth: false);

    final token =
        response['token'] ??
        response['access_token'] ??
        response['data']?['token'];
    final userData =
        response['user'] ?? response['data']?['user'] ?? response['data'];

    UserModel? user;
    if (userData != null && userData is Map<String, dynamic>) {
      user = UserModel.fromJson(userData);
    }

    if (token != null) {
      await SharedPrefsHelper.saveToken(token);
    }

    return ApiResponse<UserModel>(
      success: true,
      message: response['message'] ?? 'Login berhasil',
      data: user,
      token: token,
    );
  }

  /// Logout
  Future<void> logout() async {
    try {
      await _apiService.post(AppConstants.logoutEndpoint, {}, withAuth: true);
    } catch (_) {
      // Even if API call fails, clear local data
    } finally {
      await SharedPrefsHelper.clearAll();
    }
  }

  /// Get user profile
  Future<UserModel> getProfile() async {
    final response = await _apiService.get(AppConstants.profileEndpoint);
    final userData = response['data'] ?? response['user'] ?? response;
    return UserModel.fromJson(userData);
  }

  /// Edit profile
  Future<ApiResponse<UserModel>> editProfile({
    required String name,
    required String email,
  }) async {
    final response = await _apiService.put(AppConstants.editProfileEndpoint, {
      'name': name,
      'email': email,
    });

    final userData = response['data'] ?? response['user'] ?? response;
    UserModel? user;
    if (userData is Map<String, dynamic>) {
      user = UserModel.fromJson(userData);
    }

    return ApiResponse<UserModel>(
      success: true,
      message: response['message'] ?? 'Profil berhasil diperbarui',
      data: user,
    );
  }
}
