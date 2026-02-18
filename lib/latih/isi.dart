import 'package:flutter/material.dart';

class IsiHome extends StatelessWidget {
  const IsiHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
            height: 200,
            child: Image.asset('assets/images/l${index + 1}.png'),
          );
        },
      ),
    );
  }
}
