import 'package:flutter/material.dart';

class LoginD11 extends StatelessWidget {
  const LoginD11({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image.asset('assets/images/logof1.png', height: 300),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Platform terpercaya untuk menemukan partner dan info kompetisi terbaik.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(color: Colors.blue.withAlpha(60)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.people),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cari Partner Lomba',
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Temukan rekan tim yang memiliki keahlian dan visi yang sama untuk menang.',
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(color: Colors.red.withAlpha(60)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Temukan Info Lomba',
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Dapatkan update kompetisi nasional hingga internasional secara real-time.',
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.green.withAlpha(60),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.message),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Terhubung dengan Peserta',
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Bangun koneksi dan diskusikan strategi dengan peserta dari berbagai daerah.',
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
