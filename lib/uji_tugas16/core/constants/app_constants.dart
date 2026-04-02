class AppConstants {
  // Base URL
  static const String baseUrl = 'https://appabsensi.mobileprojp.com';

  // SharedPreferences Keys
  static const String tokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String themeModeKey = 'theme_mode';

  // API Endpoints (with /api prefix used by backend)
  static const String registerEndpoint = '/api/register';
  static const String loginEndpoint = '/api/login';
  static const String logoutEndpoint = '/api/logout';
  static const String checkInEndpoint = '/api/absen-check-in';
  static const String checkOutEndpoint = '/api/absen-check-out';
  static const String historyEndpoint = '/api/history-absen';
  static const String profileEndpoint = '/api/profile';
  static const String editProfileEndpoint = '/api/edit-profile';
  static const String deleteAbsenEndpoint = '/api/delete-absen';
  static const String trainingEndpoint = '/api/trainings';
  static const String statisticEndpoint = '/api/statistic-absen';
  static const String todayAbsenEndpoint = '/api/today-absen';

  // Google Maps API Key - Replace with your actual key
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
}
