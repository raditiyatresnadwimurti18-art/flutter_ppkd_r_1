import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter9/models/dataevent.dart';

class Model extends StatefulWidget {
  const Model({super.key});

  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  @override
  Widget build(BuildContext context) {
    final data = daftarEvent;
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.network(data[index].gambar ?? ''),
          title: Text(data[index].event ?? ''),
          subtitle: Text(data[index].kuota ?? ''),
        );
      },
    );
  }
}
