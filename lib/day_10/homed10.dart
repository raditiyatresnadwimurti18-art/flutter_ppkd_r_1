import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/day_10/isid10.dart';
import 'package:flutter_ppkd_r_1/day_7/tugas2flutter.dart';
import 'package:flutter_ppkd_r_1/latih/home.dart';

class HomeD10 extends StatefulWidget {
  const HomeD10({super.key});

  @override
  State<HomeD10> createState() => _HomeD10State();
}

class _HomeD10State extends State<HomeD10> {
  int a = 0;

  void decrement() {
    a++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Datang'),
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Latih()),
            );
          },
          child: Image.asset('assets/images/logof1.png', height: 34),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Container(color: Colors.blueGrey, height: 4),
        ),
        actions: [
          IconButton(
            iconSize: 34,
            onPressed: decrement,
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: ListView(children: [SizedBox(height: 10), IsiD10()]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.explore_rounded),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Tugas2flutter()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
