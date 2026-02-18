import 'package:flutter/material.dart';

class IsiGaleri extends StatelessWidget {
  const IsiGaleri({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('List Lomba', style: TextStyle(fontSize: 34)),
        GridView.count(
          crossAxisSpacing: 20,
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            for (int i = 0; i < 6; i++)
              Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  Column(
                    children: [
                      Image.asset('assets/images/l${i + 1}.png'),
                      Text('Lomba ke-${i + 1}'),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
