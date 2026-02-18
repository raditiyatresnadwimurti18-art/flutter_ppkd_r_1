import 'package:flutter/material.dart';

class Scrol1 extends StatelessWidget {
  const Scrol1({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6, // Jumlah card event
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            width: double.infinity,
            height: 200, // Tinggi container foto
            decoration: BoxDecoration(
              color: Colors.red, // Container warna merah sesuai permintaan
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                // Nanti ganti NetworkImage dengan link gambar aslimu
                image: Image.asset('assets/images/l${index + 1}.png').image,
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Overlay transparan biar teks terbaca
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 15,
                  child: Text(
                    "Lomba Ke-${index + 1}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
