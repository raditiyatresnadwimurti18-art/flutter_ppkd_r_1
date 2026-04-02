import '../models/api_response.dart';
import '../models/attendance_model.dart';
import '../services/api_service.dart';
import '../../core/constants/app_constants.dart';

class AttendanceRepository {
  final ApiService _apiService = ApiService();

  /// Check In
  Future<ApiResponse<AttendanceModel>> checkIn({
    required double latitude,
    required double longitude,
  }) async {
    final response = await _apiService.post(
      AppConstants.checkInEndpoint,
      {
        'latitude': latitude,
        'longitude': longitude,
      },
      withAuth: true,
    );

    final absenData = response['data'] ?? response['absen'] ?? response;
    AttendanceModel? model;
    if (absenData is Map<String, dynamic>) {
      model = AttendanceModel.fromJson(absenData);
    }

    return ApiResponse<AttendanceModel>(
      success: true,
      message: response['message'] ?? 'Check-in berhasil',
      data: model,
    );
  }

  /// Check Out
  Future<ApiResponse<AttendanceModel>> checkOut({
    required double latitude,
    required double longitude,
  }) async {
    final response = await _apiService.post(
      AppConstants.checkOutEndpoint,
      {
        'latitude': latitude,
        'longitude': longitude,
      },
      withAuth: true,
    );

    final absenData = response['data'] ?? response['absen'] ?? response;
    AttendanceModel? model;
    if (absenData is Map<String, dynamic>) {
      model = AttendanceModel.fromJson(absenData);
    }

    return ApiResponse<AttendanceModel>(
      success: true,
      message: response['message'] ?? 'Check-out berhasil',
      data: model,
    );
  }

  /// Get attendance history
  Future<List<AttendanceModel>> getHistory() async {
    final response = await _apiService.get(AppConstants.historyEndpoint);
    final List<dynamic> data = response['data'] ?? response['history'] ?? [];
    return data.map((e) => AttendanceModel.fromJson(e)).toList();
  }

  /// Get today's attendance
  Future<AttendanceModel?> getTodayAbsen() async {
    try {
      final response = await _apiService.get(AppConstants.todayAbsenEndpoint);
      final data = response['data'] ?? response['absen'];
      if (data == null) return null;
      return AttendanceModel.fromJson(data);
    } catch (_) {
      return null;
    }
  }

  /// Get attendance statistics
  Future<StatisticModel?> getStatistics() async {
    try {
      final response = await _apiService.get(AppConstants.statisticEndpoint);
      final data = response['data'] ?? response['statistic'] ?? response;
      if (data is Map<String, dynamic>) {
        return StatisticModel.fromJson(data);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Delete attendance record
  Future<ApiResponse<void>> deleteAbsen(int id) async {
    final response = await _apiService.delete(
      AppConstants.deleteAbsenEndpoint,
      queryParams: {'id': id.toString()},
    );

    return ApiResponse<void>(
      success: true,
      message: response['message'] ?? 'Absen berhasil dihapus',
    );
  }
}
