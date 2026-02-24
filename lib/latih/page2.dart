import 'package:flutter/material.dart';

class Page2Latih extends StatefulWidget {
  const Page2Latih({super.key});

  @override
  State<Page2Latih> createState() => _Page2LatihState();
}

class _Page2LatihState extends State<Page2Latih> {
  // Menyimpan kategori yang sedang dipilih
  String selectedCategory = 'Semua';

  final List<String> categories = ['Semua', 'Teknologi', 'Bisnis', 'Desain'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categories.map((category) {
        bool isSelected = selectedCategory == category;

        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ChoiceChip(
            label: Text(category),
            selected: isSelected,
            // Warna saat dipilih (biru seperti di gambar)
            selectedColor: const Color(0xFF6366F1),
            // Warna teks
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            // Warna background saat tidak dipilih
            backgroundColor: Colors.grey[100],
            // Menghilangkan garis pinggir dan mengatur kebulatan (rounded)
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: Colors.transparent),
            ),
            onSelected: (bool selected) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),
        );
      }).toList(),
    );
  }
}
