import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/day_10/homed10.dart';
import 'package:flutter_ppkd_r_1/latih/isi.dart';
import 'package:flutter_ppkd_r_1/latih/navbar.dart';
import 'package:flutter_ppkd_r_1/latih/page2.dart';
import 'package:flutter_ppkd_r_1/latih/widget1.dart';

class Latih extends StatefulWidget {
  const Latih({super.key});

  @override
  State<Latih> createState() => _LatihState();
}

class _LatihState extends State<Latih> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeD10()),
            );
          },
          child: Image.asset('assets/images/logof1.png'),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Container(
            color: const Color.fromARGB(255, 211, 211, 211),
            height: 5,
          ),
        ),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
        title: Text('Campus Compete'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        // centerTitle: true,
        actions: [
          IconButton(
            iconSize: 32,
            icon: Icon(Icons.person_2_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Page2Latih()),
              );
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
