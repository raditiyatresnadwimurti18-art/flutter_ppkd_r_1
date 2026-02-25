import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter9/list.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter9/listmap.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter9/model.dart';

class HomeT9 extends StatefulWidget {
  const HomeT9({super.key});

  @override
  State<HomeT9> createState() => _HomeT9State();
}

class _HomeT9State extends State<HomeT9> {
  int _selectIndex = 0;
  static const List<Widget> _widgetSaya = <Widget>[
    ListMap(),
    ListD9(),
    Model(),
  ];
  void _ketikaDitekan(int index) {
    setState(() {});
    _selectIndex = index;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tugas 9 Flutter'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(child: _widgetSaya.elementAt(_selectIndex)),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.abc),
              title: Text('ListMap'),
              selected: _selectIndex == 0,
              onTap: () {
                _ketikaDitekan(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.abc_outlined),
              title: Text('List'),
              selected: _selectIndex == 1,
              onTap: () {
                _ketikaDitekan(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.abc_rounded),
              title: Text('Model'),
              selected: _selectIndex == 2,
              onTap: () {
                _ketikaDitekan(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
