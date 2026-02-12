import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/day_5/column.dart';

class RowDay5 extends StatelessWidget {
  const RowDay5({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 1; i < 7; i++)
          Text(
            'Hobi Saya $i',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ColumnDay5()),
            );
          },
          child: Text('Kembali'),
        ),
      ],
    );
  }
}
