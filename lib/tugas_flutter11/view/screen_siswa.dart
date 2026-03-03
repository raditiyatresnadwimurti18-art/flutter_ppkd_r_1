import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/extension/navigator.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/database/siswa_controler.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/model/tugas11_model.dart';
import 'package:flutter_ppkd_r_1/util/decoration_form.dart';

class ScreenSiswa extends StatefulWidget {
  const ScreenSiswa({super.key});

  @override
  State<ScreenSiswa> createState() => _ScreenSiswaState();
}

class _ScreenSiswaState extends State<ScreenSiswa> {
  late List<Tugas11Model> dataSiswa = [];
  @override
  void initState() {
    super.initState();
    getDataSiswa();
  }

  Future<void> getDataSiswa() async {
    await Future.delayed(Duration(seconds: 1));
    dataSiswa = await SiswaControler.getAllsiswa();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            dataSiswa.isEmpty || dataSiswa == []
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Kelas: ${items.kelas}"),
                                            Text("No Tlpon: ${items.tlpon}"),
                                            Text("Email: ${items.emailSiswa}"),
                                            Text("Kota Asal: ${items.kota}"),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await showEditDialog(
                                                context,
                                                items,
                                              );
                                              dataSiswa =
                                                  await SiswaControler.getAllsiswa();
                                              setState(() {});
                                            },
                                            icon: Icon(Icons.edit),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              await showDeleteDialog(
                                                context,
                                                items.id!,
                                              );
                                              dataSiswa =
                                                  await SiswaControler.getAllsiswa();
                                              setState(() {});
                                            },
                                            icon: Icon(Icons.delete),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> showEditDialog(BuildContext context, Tugas11Model items) async {
    final namaController = TextEditingController(text: items.nama);
    final kelasController = TextEditingController(text: items.kelas);
    final tlponControler = TextEditingController(text: items.tlpon);
    final emailControler = TextEditingController(text: items.emailSiswa);
    final kotaControler = TextEditingController(text: items.kota);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Siswa"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: namaController,
                decoration: decorationContstan(hintText: "Nama"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: kelasController,
                decoration: decorationContstan(hintText: "Kelas"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: tlponControler,
                decoration: decorationContstan(hintText: "No Tlpon"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailControler,
                decoration: decorationContstan(hintText: "Email"),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: kotaControler,
                decoration: decorationContstan(hintText: "Kota"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (items.id == null) {
                  return;
                }
                await SiswaControler.updateSiswa(
                  Tugas11Model(
                    id: items.id,
                    nama: namaController.text,
                    kelas: kelasController.text,
                    tlpon: tlponControler.text,
                    emailSiswa: emailControler.text,
                    kota: kotaControler.text,
                  ),
                );
                context.pop();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Siswa di update")));
              },
              child: Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showDeleteDialog(BuildContext context, int id) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: Text("Apakah anda yakin ingin menghapus data ini?"),
          actions: [
            TextButton(
              onPressed: () {
                context.pop(false);
              },
              child: Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                context.pop(true);
              },
              child: Text("Hapus bae"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await SiswaControler.deleteSiswa(id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Data berhasil dihapus")));
      setState(() {});
    }
  }
}
