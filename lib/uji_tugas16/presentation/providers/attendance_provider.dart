import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/models/attendance_model.dart';
import '../../data/repositories/attendance_repository.dart';

enum AttendanceStatus { initial, loading, success, error }

class AttendanceProvider extends ChangeNotifier {
  final AttendanceRepository _repo = AttendanceRepository();

  AttendanceStatus _status = AttendanceStatus.initial;
  String? _errorMessage;
  List<AttendanceModel> _history = [];
  AttendanceModel? _todayAbsen;
  StatisticModel? _statistic;
  Position? _currentPosition;
  bool _loadingLocation = false;

  AttendanceStatus get status => _status;
  String? get errorMessage => _errorMessage;
  List<AttendanceModel> get history => _history;
  AttendanceModel? get todayAbsen => _todayAbsen;
  StatisticModel? get statistic => _statistic;
  Position? get currentPosition => _currentPosition;
  bool get loadingLocation => _loadingLocation;
  bool get isLoading => _status == AttendanceStatus.loading;

  bool get sudahCheckIn => _todayAbsen != null && _todayAbsen!.sudahCheckIn;
  bool get sudahCheckOut => _todayAbsen != null && _todayAbsen!.sudahCheckOut;

  /// Request location permission and get current position
  Future<Position?> getCurrentLocation() async {
    _loadingLocation = true;
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Layanan lokasi tidak aktif. Aktifkan GPS Anda.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Izin lokasi ditolak.');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Izin lokasi ditolak permanen. Ubah di pengaturan aplikasi.',
        );
      }

      Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      );
      _loadingLocation = false;
      notifyListeners();
      return _currentPosition;
    } catch (e) {
      _loadingLocation = false;
      notifyListeners();
      rethrow;
    }
  }

  /// Check In
  Future<bool> checkIn() async {
    _status = AttendanceStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final position = await getCurrentLocation();
      if (position == null) throw Exception('Gagal mendapatkan lokasi.');

      final result = await _repo.checkIn(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (result.data != null) {
        _todayAbsen = result.data;
      }

      _status = AttendanceStatus.success;
      notifyListeners();

      // Refresh data
      await loadDashboardData();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _status = AttendanceStatus.error;
      notifyListeners();
      return false;
    }
  }

  /// Check Out
  Future<bool> checkOut() async {
    _status = AttendanceStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final position = await getCurrentLocation();
      if (position == null) throw Exception('Gagal mendapatkan lokasi.');

      final result = await _repo.checkOut(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (result.data != null) {
        _todayAbsen = result.data;
      }

      _status = AttendanceStatus.success;
      notifyListeners();

      // Refresh data
      await loadDashboardData();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _status = AttendanceStatus.error;
      notifyListeners();
      return false;
    }
  }

  /// Load dashboard data (today's absen + statistics)
  Future<void> loadDashboardData() async {
    try {
      final results = await Future.wait([
        _repo.getTodayAbsen(),
        _repo.getStatistics(),
      ]);
      _todayAbsen = results[0] as AttendanceModel?;
      _statistic = results[1] as StatisticModel?;
      notifyListeners();
    } catch (_) {}
  }

  /// Load history
  Future<void> loadHistory() async {
    _status = AttendanceStatus.loading;
    notifyListeners();
    try {
      _history = await _repo.getHistory();
      _status = AttendanceStatus.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _status = AttendanceStatus.error;
    }
    notifyListeners();
  }

  /// Delete absen
  Future<bool> deleteAbsen(int id) async {
    try {
      await _repo.deleteAbsen(id);
      _history.removeWhere((e) => e.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    if (_status == AttendanceStatus.error) {
      _status = AttendanceStatus.initial;
    }
    notifyListeners();
  }
}
