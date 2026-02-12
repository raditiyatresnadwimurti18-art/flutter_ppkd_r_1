import 'package:flutter/material.dart';

class Kontak extends StatelessWidget {
  const Kontak({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Hubungi Kami',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color.fromARGB(253, 255, 255, 255),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.email_outlined),
                  SizedBox(width: 10),
                  Text('raditya.tresna.dwimurti@gmail.com'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.phone_outlined),
                  SizedBox(width: 10),
                  Text('082123456789'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 10),
                  Text('Jakarta, Indonesia'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
