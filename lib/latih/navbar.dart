import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 60,
      color: Colors.blueAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.home, size: 32, color: Colors.white),
          Icon(Icons.event, size: 32, color: Colors.white),
          Icon(Icons.laptop_mac_rounded, size: 32, color: Colors.white),
          Icon(Icons.search, size: 32, color: Colors.white),
          Icon(Icons.person_2_outlined, size: 32, color: Colors.white),
        ],
      ),
    );
  }
}
