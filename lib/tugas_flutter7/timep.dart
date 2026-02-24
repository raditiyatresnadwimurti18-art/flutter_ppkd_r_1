import 'package:flutter/material.dart';

class TimeP7 extends StatefulWidget {
  const TimeP7({super.key});

  @override
  State<TimeP7> createState() => _TimeP7State();
}

TimeOfDay? selectedTime;

class _TimeP7State extends State<TimeP7> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            border: Border.all(color: Colors.black),
          ),
          child: ElevatedButton(
            onPressed: () async {
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (picked != null) {
                setState(() {
                  selectedTime = picked;
                });
              }
            },
            child: Text("Pilih Jam"),
          ),
        ),
        Text('Pengingat diatur jam $selectedTime'),
      ],
    );
  }
}
