import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/day_5/tugas1flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter demo',
      home: Tugas1(),
    );
  }
}
