import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/day_5/row.dart';
import 'package:flutter_ppkd_r_1/day_5/tugas1flutter.dart';

class ColumnDay5 extends StatelessWidget {
  const ColumnDay5({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Nama :Habibie",
          style: TextStyle(fontSize: 30),
        ), //fontsize : Mengatur size font
        Text(
          "Umur : 17 Tahun", //Text : Widget untuk menampilkan teks
          style: TextStyle(
            //TextStyle : Widget untuk mengatur style teks
            color: Colors.blue, //color : Mengatur warna font
            fontSize: 20, //fontSize : Mengatur ukuran font
            fontWeight: FontWeight.bold, //fontWeight : Mengatur ketebalan font
          ),
        ),
        Text(
          "Pekerjaan : Instruktur",
          style: TextStyle(
            //TextStyle : Widget untuk mengatur style teks
            color: Colors.red, //color : Mengatur warna font
            fontSize: 20, //fontSize : Mengatur ukuran font
            fontWeight: FontWeight.w400, //fontWeight : Mengatur ketebalan font
            decoration:
                TextDecoration.underline, //decoration : Mengatur dekorasi teks
            fontStyle: FontStyle
                .italic, //fontStyle : Mengatur gaya font (italic atau normal)
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Tugas1()),
            );
          },
          child: Text('Kembali'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RowDay5()),
            );
          },
          child: Text('Halaman Hobi'),
        ),
      ],
    );
  }
}
