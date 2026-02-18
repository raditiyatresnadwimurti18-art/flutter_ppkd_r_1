import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/day_5/tugas1flutter.dart';
import 'package:flutter_ppkd_r_1/day_7/day7.dart';
import 'package:flutter_ppkd_r_1/day_7/tugas2flutter.dart';
import 'package:flutter_ppkd_r_1/tugas3/textfield.dart';
import 'package:flutter_ppkd_r_1/tugas3/tugas3.dart';
import 'package:flutter_ppkd_r_1/latih/home.dart';

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
      home: Tugas3(),
      // home: Latih(),
    );
  }
}
