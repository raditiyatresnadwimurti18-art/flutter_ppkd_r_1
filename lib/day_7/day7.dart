import 'package:flutter/material.dart';

class Day7 extends StatelessWidget {
  const Day7({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Aplikasi Pencari Lomba'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
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
              color: Color.fromARGB(255, 219, 198, 165),
              borderRadius: BorderRadius.circular(30),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
