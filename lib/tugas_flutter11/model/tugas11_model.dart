import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Tugas11Model {
  final String nama;
  final String kelas;
  final String emailSiswa;
  final String tlpon;
  final String kota;
  Tugas11Model({
    required this.nama,
    required this.kelas,
    required this.emailSiswa,
    required this.tlpon,
    required this.kota,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'kelas': kelas,
      'emailSiswa': emailSiswa,
      'tlpon': tlpon,
      'kota': kota,
    };
  }

  factory Tugas11Model.fromMap(Map<String, dynamic> map) {
    return Tugas11Model(
      nama: map['nama'] as String,
      kelas: map['kelas'] as String,
      emailSiswa: map['emailSiswa'] as String,
      tlpon: map['tlpon'] as String,
      kota: map['kota'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Tugas11Model.fromJson(String source) =>
      Tugas11Model.fromMap(json.decode(source) as Map<String, dynamic>);
}
