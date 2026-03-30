import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/database/preference.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/login.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/login1.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/view/cr_siswa.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/view/splashscreen.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter14/view/splash_screent14.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter14/view/tugas14.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceHandler().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter demo',

      // home: Tugas2flutter(),
      // home: Tugas1(),
      // home: Tugas3(),
      // home: Tugas4(),
      // home: HomeT7(),
      // home: HomeT8(),
      // home: HomeT9(),
      // home: Login61(),
      // home: SplashscreenT16(),
      // home: CrSiswaDay17(),
      // home: HomeD10(),
      // home: Latih(),
      // home: Homelatih2(),
      // home: Tugas14(),
      home: SplashScreenT14(),
    );
  }
}
