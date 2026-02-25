import 'package:flutter/material.dart';

List<String> _daftarLomba = [
  'Lomba Tari',
  'Lomba Ngoding',
  'Lomba Basket',
  'Lomba Debat Bahasa Inggris',
  'Lomba Fotografi Alam',
  'Lomba Desain Poster',
  'Lomba Catur Cepat',
  'Lomba Menyanyi Solo',
  'Lomba Baca Puisi',
  'Lomba Karya Tulis Ilmiah',
  'Lomba Esai Nasional',
  'Lomba Mobile Legends',
  'Lomba Maraton 5K',
  'Lomba Bulu Tangkis',
  'Lomba Masak Nusantara',
  'Lomba Pidato Bahasa Indonesia',
  'Lomba Kaligrafi',
  'Lomba Stand Up Comedy',
  'Lomba Robotik',
  'Lomba Cerdas Cermat',
  'Lomba Akustik Band',
  'Lomba Desain UI/UX',
  'Lomba Short Movie',
  'Lomba Vlog Kreatif',
  'Lomba Menggambar Manga',
  'Lomba Fashion Show',
  'Lomba Panahan',
  'Lomba Renang Gaya Bebas',
  'Lomba Tenis Meja',
  'Lomba E-Sport PUBG',
];

class ListD9 extends StatelessWidget {
  const ListD9({super.key});

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Container(
    //     height: 200,
    //     width: 200,
    //     decoration: BoxDecoration(color: const Color.fromARGB(255, 7, 255, 48)),
    //   ),
    // );
    return ListView.builder(
      itemCount: _daftarLomba.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text(_daftarLomba[index]));
      },
    );
  }
}
