import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/day_7/kontak.dart';
import 'package:flutter_ppkd_r_1/day_7/produk.dart';

class Tugas2flutter extends StatelessWidget {
  const Tugas2flutter({super.key});

  Widget? get bacgroundColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Image.asset('assets/images/logo2.png'),
        centerTitle: true,
        title: Text(
          'Selamat Datang',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(children: [DataProduk(), Kontak()]),
      backgroundColor: const Color.fromARGB(255, 168, 168, 168),
    );
  }
}
