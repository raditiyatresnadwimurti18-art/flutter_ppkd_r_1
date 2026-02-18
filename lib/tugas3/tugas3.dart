import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas3/galeri.dart';
import 'package:flutter_ppkd_r_1/day_8/textfield.dart';
import 'package:flutter_ppkd_r_1/tugas3/galeri.dart';

class Tugas3 extends StatelessWidget {
  const Tugas3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat datang'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(children: [Widget1(), IsiGaleri()]),
      ),
    );
  }
}
