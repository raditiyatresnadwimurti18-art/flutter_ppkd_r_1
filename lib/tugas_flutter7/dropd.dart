import 'package:flutter/material.dart';

class DropD7 extends StatefulWidget {
  const DropD7({super.key});

  @override
  State<DropD7> createState() => _DropD7State();
}

class _DropD7State extends State<DropD7> {
  String? selected;
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
              DropdownButton<String>(
                value: selected,
                hint: Text("Pilih kategori Produk"),
                items: ["Elektronik", "Pakaian", "Makanan", "Lainnya"].map((
                  String val,
                ) {
                  return DropdownMenuItem(value: val, child: Text(val));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
              Text('Anda memilih $selected'),
            ],
          ),
        ),
      ],
    );
  }
}
