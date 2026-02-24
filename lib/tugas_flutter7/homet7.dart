import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter7/checkb7.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter7/datep.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter7/dropd.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter7/homet8.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter7/switch7.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter7/timep.dart';

class HomeT7 extends StatefulWidget {
  const HomeT7({super.key});

  @override
  State<HomeT7> createState() => _HomeT7State();
}

class _HomeT7State extends State<HomeT7> {
  int _selectIndex = 0;
  static const List<Widget> _widgetOption = <Widget>[
    CheckB7(),
    DateP7(),
    DropD7(),
    Switch7(),
    TimeP7(),
    Profile(),
  ];
  void _ketikaDitekan(int index) {
    _selectIndex = index;
    setState(() {});
    Navigator.pop(context);
  }

  void _ketikaDitekan2(int index2) {
    _selectIndex = index2;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool showDrawer = _selectIndex != 5;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tugas 7'),
        centerTitle: true,
        backgroundColor: isOn ? Colors.black : Colors.amber,
      ),
      body: Center(child: _widgetOption.elementAt(_selectIndex)),

      drawer: showDrawer
          ? Drawer(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.check_box),
                    title: Text('check box'),
                    selected: _selectIndex == 0,
                    onTap: () {
                      _ketikaDitekan(0);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.date_range),
                    title: Text('Date Picker'),
                    selected: _selectIndex == 1,
                    onTap: () {
                      _ketikaDitekan(1);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.pin_drop),
                    title: Text('Drop down'),
                    selected: _selectIndex == 2,
                    onTap: () {
                      _ketikaDitekan(2);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.switch_camera),
                    title: Text('Swich'),
                    selected: _selectIndex == 3,
                    onTap: () {
                      _ketikaDitekan(3);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.time_to_leave),
                    title: Text('Time Picker'),
                    selected: _selectIndex == 4,
                    onTap: () {
                      _ketikaDitekan(4);
                    },
                  ),
                ],
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Profil'),
        ],
        currentIndex: _selectIndex == 5 ? 1 : 0,
        onTap: (value) {
          if (value == 0) {
            _ketikaDitekan2(0);
          } else {
            _ketikaDitekan2(5);
          }
        },
        // selectedItemColor: Colors.blueAccent,
      ),
    );
  }
}
