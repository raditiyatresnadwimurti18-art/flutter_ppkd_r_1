import 'package:flutter/material.dart';

class DateP7 extends StatefulWidget {
  const DateP7({super.key});

  @override
  State<DateP7> createState() => _DateP7State();
}

DateTime? selectedDate;

class _DateP7State extends State<DateP7> {
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
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2027),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Text('Pilih tanggal'),
              ),
              SizedBox(height: 35),
              Text('Tanggal Lahir: $selectedDate'),
            ],
          ),
        ),
      ],
    );
  }
}
