import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas4/isi.dart';
import 'package:flutter_ppkd_r_1/tugas4/textfield2.dart';

class Tugas4 extends StatelessWidget {
  const Tugas4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tugas4'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(children: [TextField2(), IsiList()]),
        ],
      ),
    );
  }
}
