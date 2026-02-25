import 'package:flutter/material.dart';

class Page1L2 extends StatelessWidget {
  const Page1L2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(color: Colors.amber),
        ),
      ],
    );
  }
}
