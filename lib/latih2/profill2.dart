import 'package:flutter/material.dart';

class ProfilL2 extends StatefulWidget {
  const ProfilL2({super.key});

  @override
  State<ProfilL2> createState() => _ProfilL2State();
}

class _ProfilL2State extends State<ProfilL2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(color: Colors.amber),
        ),
      ],
    );
  }
}
