import 'package:flutter/material.dart';

class Widget1 extends StatelessWidget {
  const Widget1({super.key});

  @override
  Container build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Masukan Email',
              hintText: 'xxx@gmail.com',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(45),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.phone),
              labelText: 'Masukan No Hp',
              hintText: '08xxx',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(45),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.house),
              labelText: 'Masukan Alamat',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(45),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.people),
              labelText: 'Masukan Nama',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
