import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/latih/isi.dart';
import 'package:flutter_ppkd_r_1/latih/navbar.dart';
import 'package:flutter_ppkd_r_1/latih/widget1.dart';

class Latih extends StatelessWidget {
  const Latih({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home, size: 32),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
        title: Text('Event Utama'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            iconSize: 32,
            icon: Icon(Icons.person_2_outlined),
            onPressed: () {
              // Aksi ketika tombol pengaturan ditekan
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          MyWidget1(),
          SizedBox(height: 10),
          IsiHome(),
          // SizedBox(height: 10),
          // Scrol1(),
          NavBar(),
        ],
      ),
    );
  }
}
