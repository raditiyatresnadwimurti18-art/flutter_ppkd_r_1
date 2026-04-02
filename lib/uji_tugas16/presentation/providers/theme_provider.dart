import 'package:flutter/material.dart';
import '../../core/utils/shared_prefs_helper.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  Future<void> loadTheme() async {
    final isDark = SharedPrefsHelper.getThemeMode();
    _themeMode = (isDark == true) ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await SharedPrefsHelper.saveThemeMode(_themeMode == ThemeMode.dark);
    notifyListeners();
  }
}
