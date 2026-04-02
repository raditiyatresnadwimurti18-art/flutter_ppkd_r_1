import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../core/utils/shared_prefs_helper.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepo = AuthRepository();

  AuthStatus _status = AuthStatus.initial;
  UserModel? _user;
  String? _errorMessage;
  List<TrainingModel> _trainings = [];
  bool _loadingTrainings = false;

  AuthStatus get status => _status;
  UserModel? get user => _user;
  String? get errorMessage => _errorMessage;
  List<TrainingModel> get trainings => _trainings;
  bool get loadingTrainings => _loadingTrainings;
  bool get isLoading => _status == AuthStatus.loading;

  Future<void> checkAuthStatus() async {
    if (SharedPrefsHelper.isLoggedIn()) {
      try {
        _user = await _authRepo.getProfile();
        _status = AuthStatus.authenticated;
      } catch (_) {
        _status = AuthStatus.unauthenticated;
      }
    } else {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> loadTrainings() async {
    _loadingTrainings = true;
    notifyListeners();
    try {
      _trainings = await _authRepo.getTrainings();
      print('DEBUG: Loaded ${_trainings.length} trainings from API');
      for (var training in _trainings) {
        print(
          'DEBUG: Training - ID: ${training.id}, Name: ${training.namaTraining}',
        );
      }
    } catch (e) {
      print('DEBUG: Error loading trainings: $e');
      _trainings = [];
    }
    _loadingTrainings = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authRepo.login(email: email, password: password);
      _user = result.data;
      // Fetch full profile after login
      try {
        _user = await _authRepo.getProfile();
      } catch (_) {}
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String batch,
    required int trainingId,
  }) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authRepo.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        batch: batch,
        trainingId: trainingId,
      );
      _user = result.data;
      try {
        _user = await _authRepo.getProfile();
      } catch (_) {}
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authRepo.logout();
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  Future<bool> editProfile(String name, String email) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authRepo.editProfile(name: name, email: email);
      if (result.data != null) {
        _user = result.data;
      } else {
        // Update locally
        _user = UserModel(
          id: _user?.id,
          name: name,
          email: email,
          batch: _user?.batch,
          training: _user?.training,
          trainingId: _user?.trainingId,
        );
      }
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _status = AuthStatus.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> refreshProfile() async {
    try {
      _user = await _authRepo.getProfile();
      notifyListeners();
    } catch (_) {}
  }

  void clearError() {
    _errorMessage = null;
    if (_status == AuthStatus.error) {
      _status = AuthStatus.authenticated;
    }
    notifyListeners();
  }
}
