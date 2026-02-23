import 'package:flutter/material.dart';

import 'package:flutter_ppkd_r_1/tugas_flutter6/login.dart';

class HomeT6 extends StatefulWidget {
  const HomeT6({super.key});

  @override
  State<HomeT6> createState() => _HomeT6State();
}

class _HomeT6State extends State<HomeT6> {
  bool xt6 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/logof1.png'),
        title: Text('Discovery', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login6()),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 139, 139, 139),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text(
                'Hallo, Peserta\u{1F44B}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text('Temukan kompetisi terbaik untuk karirmu.'),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Cari kompetisi impoanmu',
                  icon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.filter_list),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Kategori populer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    'Lihat Semua',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
