import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/database/siswa_controler.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/model/tugas11_model.dart';

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
                  ),
          ],
        ),
      ),
    );
  }
}
