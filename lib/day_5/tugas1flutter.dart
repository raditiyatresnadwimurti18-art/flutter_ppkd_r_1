import 'package:flutter/material.dart';

class Tugas1 extends StatelessWidget {
  const Tugas1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Saya'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Raditya Tresna Dwimurti',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on),
              Text('Jakarta, Indonesia'),
            ],
          ),
          Text('Saya sekarang berkuliah di universitas gunadarma semester 3',
              style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}