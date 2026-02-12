import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/day_5/column.dart';

class Tugas1 extends StatelessWidget {
  const Tugas1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ColumnDay5()),
            );
          },
          icon: Icon(Icons.menu),
        ),
        title: Text('Profil Saya', textAlign: TextAlign.center),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Text(
            'Raditya Tresna Dwimurti',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.location_on), Text('Jakarta, Indonesia')],
          ),
          Text(
            'Saya sekarang berkuliah di universitas gunadarma semester 3',
            style: TextStyle(fontSize: 14),
          ),

          Row(
            children: [
              Text(
                'Hobi Saya',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Hobi Saya',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                'Hobi Saya',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
