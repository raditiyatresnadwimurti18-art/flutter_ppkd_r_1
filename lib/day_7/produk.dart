import 'package:flutter/material.dart';

class DataProduk extends StatelessWidget {
  const DataProduk({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Text(
          'Daftar Event',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Container(
              width: 180,
              height: 180,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/prod1.png',
                    width: 158,
                    height: 158,
                  ),
                  Text('Kuota : 5'),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: 180,
              height: 180,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/prod2.png',
                    width: 158,
                    height: 158,
                  ),
                  Text('Kuota : 3'),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Container(
              width: 180,
              height: 180,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/prod3.png',
                    width: 158,
                    height: 158,
                  ),
                  Text('Kuota : 5'),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: 180,
              height: 180,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/prod4.png',
                    width: 158,
                    height: 158,
                  ),
                  Text('Kuota : 3'),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
