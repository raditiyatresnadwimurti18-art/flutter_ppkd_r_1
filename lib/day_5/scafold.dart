import 'package:flutter/material.dart';

class ScafoldDay5 extends StatelessWidget {
  const ScafoldDay5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 206, 206, 206),
        title: Text('contoh scafold'),
        centerTitle: true,
        leading: BackButton(),

      ),
      body:Column(
        children: [
          Container(
            child: Text('Halo ini contoh scafold'),
            height: 100,
            color: Colors.red,
          ),
          Container(
            height: 100,
            color: Colors.green,
          ),
          Container(
            height: 100,
            color: Colors.blue,
          )
        ],
      )
    );
  }
}