import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/day_10/homed10.dart';
import 'package:flutter_ppkd_r_1/day_11/login_pages.dart';
import 'package:flutter_ppkd_r_1/latih/home.dart';
import 'package:flutter_ppkd_r_1/tugas3/tugas3.dart';
import 'package:flutter_ppkd_r_1/tugas4/tugas4.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter6/home_t_6.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter6/login.dart';

void main() {
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
      home: Login6(),
      // home: HomeD10(),
      // home: Latih(),
    );
  }
}
