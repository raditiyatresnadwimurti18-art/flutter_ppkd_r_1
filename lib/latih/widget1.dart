import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/latih/page2.dart';

class MyWidget1 extends StatelessWidget {
  const MyWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 186, 191, 255).withOpacity(1),
        borderRadius: BorderRadius.circular(16),
        // boxShadow: [
        //   BoxShadow(
        //     color: const Color.fromARGB(255, 0, 0, 0),
        //     spreadRadius: 1,
        //     blurRadius: 5,
        //     offset: Offset(3, 3),
        //   ),
        // ],
      ),
      child: Row(
        children: [
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Page2Latih()),
              );
            },
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(Icons.event, size: 25, color: Colors.white),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 97, 73, 238),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.laptop_mac_rounded,
              size: 25,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 111, 86, 252),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.search,
              size: 25,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 80, 49, 255),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.history_edu,
              size: 25,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
