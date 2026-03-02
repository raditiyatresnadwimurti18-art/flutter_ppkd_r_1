import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/extension/navigator.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/database/siswa_controler.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/model/siswa_model.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/model/tugas11_model.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/view/screen_siswa.dart';
import 'package:flutter_ppkd_r_1/util/decoration_form.dart';

class CrSiswaDay17 extends StatefulWidget {
  const CrSiswaDay17({super.key});

  @override
  State<CrSiswaDay17> createState() => _CrSiswaDay17State();
}

class _CrSiswaDay17State extends State<CrSiswaDay17> {
  final TextEditingController nameControler = TextEditingController();
  final TextEditingController kelasControler = TextEditingController();
  final TextEditingController tlponControler = TextEditingController();
  final TextEditingController emailControler = TextEditingController();
  final TextEditingController kotaControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: nameControler,
              decoration: decorationContstan(hintText: 'nama'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: kelasControler,
              decoration: decorationContstan(hintText: 'Kelas'),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: tlponControler,
              decoration: decorationContstan(hintText: 'Tlpon'),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: emailControler,
              decoration: decorationContstan(hintText: 'Email'),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: kotaControler,
              decoration: decorationContstan(hintText: 'Kota'),
            ),
            SizedBox(height: 23),
            ElevatedButton(
              onPressed: () {
                if (nameControler.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Nama di harus di isi')),
                  );
                  return;
                }
                if (kelasControler.text.isEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Kelas belum diisi')));
                  return;
                }
                if (tlponControler.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No tlpon belum diisi')),
                  );
                  return;
                }
                if (emailControler.text.isEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Email belum diisi')));
                  return;
                }
                if (kotaControler.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Asal Kota belum diisi')),
                  );
                  return;
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Data Ditambahkan')));
                }
                SiswaControler.registerUser(
                  Tugas11Model(
                    nama: nameControler.text,
                    kelas: kelasControler.text,
                    tlpon: tlponControler.text,
                    emailSiswa: emailControler.text,
                    kota: kotaControler.text,
                  ),
                );
                nameControler.clear();
                kelasControler.clear();
                emailControler.clear();
                kotaControler.clear();
                tlponControler.clear();
                setState(() {});
              },
              child: Text('Tambah data siswa'),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.push(ScreenSiswa());
                },
                child: Text("Lihat Data Siswa"),
              ),
            ),
            FutureBuilder<List<Tugas11Model>>(
              future: SiswaControler.getAllsiswa(),

              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final dataSiswa = snapshot.data as List<Tugas11Model>;
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: dataSiswa.length,
                  itemBuilder: (BuildContext context, int index) {
                    final items = dataSiswa[index];
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.withAlpha(67),
                            borderRadius: BorderRadius.circular(34),
                            border: Border.all(color: Colors.black),
                          ),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      items.nama,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text("Kelas: ${items.kelas}"),
                                Text("No Tlpon: ${items.tlpon}"),
                                Text("Email: ${items.emailSiswa}"),
                                Text("Kota Asal: ${items.kota}"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
