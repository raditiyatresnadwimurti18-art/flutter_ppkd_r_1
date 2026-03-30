import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter14/view/tugas14.dart'; // Pastikan path ini sesuai

class SplashScreenT14 extends StatefulWidget {
  const SplashScreenT14({super.key});

  @override
  State<SplashScreenT14> createState() => _SplashScreenT14State();
}

class _SplashScreenT14State extends State<SplashScreenT14> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    // Durasi splash screen selama 2 detik
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Berpindah ke halaman Tugas14
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Tugas14()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(
        0xfff7f4f0,
      ), // Sesuaikan dengan warna tema aplikasimu
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Memanggil asset gambar
            Image.asset(
              'assets/images/splashscreentugas14.png',
              width: 500, // Sesuaikan ukuran
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            // Opsional: Loading indicator kecil di bawah gambar
            const CircularProgressIndicator(
              color: Colors.green, // Contoh warna ala e-commerce
            ),
          ],
        ),
      ),
    );
  }
}
