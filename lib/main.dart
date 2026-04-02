import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/database/preference.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/login.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/login1.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/view/cr_siswa.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/view/splashscreen.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter14/view/splash_screent14.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter14/view/tugas14.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter15/view/login_page.dart';
import 'package:flutter_ppkd_r_1/uji_tugas16/presentation/widgets/auth_wrapper.dart';
import 'package:flutter_ppkd_r_1/uji_tugas16/presentation/providers/auth_provider.dart';
import 'package:flutter_ppkd_r_1/uji_tugas16/presentation/providers/attendance_provider.dart';
import 'package:flutter_ppkd_r_1/uji_tugas16/presentation/providers/theme_provider.dart';
import 'package:flutter_ppkd_r_1/uji_tugas16/core/utils/shared_prefs_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceHandler().init();
  await SharedPrefsHelper.init();
  await initializeDateFormatting('id_ID', null);
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();
  runApp(MainApp(themeProvider: themeProvider));
}

class MainApp extends StatelessWidget {
  final ThemeProvider themeProvider;

  const MainApp({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter demo',
        home: const AuthWrapper(),
      ),
    );
  }
}
