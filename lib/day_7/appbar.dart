import 'package:flutter/material.dart';

class AppBar extends StatelessWidget {
  const AppBar({
    super.key,
    required Text title,
    required MaterialAccentColor backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Event Utama'),
      backgroundColor: Colors.blueAccent,
    );
  }
}
