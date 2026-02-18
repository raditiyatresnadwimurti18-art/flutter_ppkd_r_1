import 'package:flutter/material.dart';

class IsiList extends StatelessWidget {
  const IsiList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i <= 5; i++)
          ListTile(
            contentPadding: EdgeInsets.all(30),
            title: Text('Lomba ke-${i + 1}'),
            subtitle: Text('Seminar Lomba Karya Tulis'),
            leading: Image.asset('assets/images/l${i + 1}.png'),
          ),
      ],
    );
  }
}
