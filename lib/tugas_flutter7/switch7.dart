import 'package:flutter/material.dart';

bool isOn = false;

class Switch7 extends StatefulWidget {
  const Switch7({super.key});

  @override
  State<Switch7> createState() => _Switch7State();
}

class _Switch7State extends State<Switch7> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            border: Border.all(color: Colors.black),
          ),

          child: Column(
            children: [
              Text(isOn ? 'Aktifkan mode terang' : 'Aktifkan mode gelap'),
              Switch(
                value: isOn,
                onChanged: (val) {
                  setState(() {
                    isOn = val;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          height: 400,
          width: 400,
          decoration: BoxDecoration(color: isOn ? Colors.black : Colors.amber),
        ),
      ],
    );
  }
}
