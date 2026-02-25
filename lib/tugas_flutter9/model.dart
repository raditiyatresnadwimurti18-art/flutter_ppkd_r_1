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
    return ListView.builder(
      itemCount: daftarEvent.length,
      itemBuilder: (BuildContext context, int index) {
        final data = daftarEvent;
        return Container(
          margin: EdgeInsets.all(23),
          // height: 23,
          decoration: BoxDecoration(color: Colors.amber),
          child: ListTile(
            leading: Image.network(data[index].gambar ?? ''),
            title: Text(data[index].event ?? ''),
            subtitle: Text(data[index].kuota ?? ''),
          ),
        );
      },
    );
  }
}
