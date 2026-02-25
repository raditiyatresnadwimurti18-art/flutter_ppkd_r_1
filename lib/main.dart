import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/day_10/homed10.dart';
import 'package:flutter_ppkd_r_1/day_11/login_pages.dart';
import 'package:flutter_ppkd_r_1/latih/home.dart';
import 'package:flutter_ppkd_r_1/latih2/homelatih2.dart';
import 'package:flutter_ppkd_r_1/tugas3/tugas3.dart';
import 'package:flutter_ppkd_r_1/tugas4/tugas4.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter6/home_t_6.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter6/login.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter7/homet7.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter7/homet8.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter9/homet9.dart';

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
      // home: HomeT7(),
      // home: HomeT8(),
      home: HomeT9(),
      // home: Login6(),
      // home: HomeD10(),
      // home: Latih(),
      // home: Homelatih2(),
    );
  }
}
