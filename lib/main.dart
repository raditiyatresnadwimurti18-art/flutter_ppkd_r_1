import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas3/tugas3.dart';
import 'package:flutter_ppkd_r_1/tugas4/tugas4.dart';

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
      home: Tugas4(),
      // home: Latih(),
    );
  }
}
