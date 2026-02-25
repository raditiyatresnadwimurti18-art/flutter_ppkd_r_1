import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/latih2/page1l2.dart';
import 'package:flutter_ppkd_r_1/latih2/page2l2.dart';
import 'package:flutter_ppkd_r_1/latih2/page3l2.dart';
import 'package:flutter_ppkd_r_1/latih2/profill2.dart';

class Homelatih2 extends StatefulWidget {
  const Homelatih2({super.key});

  @override
  State<Homelatih2> createState() => _Homelatih2State();
}

class _Homelatih2State extends State<Homelatih2> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetSaye = <Widget>[
    Page1L2(),
    Page2L2(),
    Page3L2(),
    ProfilL2(),
  ];
  // void _onTap(int x) {
  //   setState(() {
  //     _selectedIndex = x;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (value) => _widgetSaye,
      ),
    );
  }
}
