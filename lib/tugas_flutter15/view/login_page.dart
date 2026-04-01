import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter15/api/api_service.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter15/view/profil_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  bool isLoading = false;

  void login() async {
    if (emailC.text.isEmpty || passwordC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email & Password wajib diisi")),
      );
      return;
    }

    setState(() => isLoading = true);

    var res = await ApiService.login(emailC.text, passwordC.text);

    setState(() => isLoading = false);

    print(res); // DEBUG

    String? token;

    // 🔍 fleksibel ambil token
    if (res['token'] != null) {
      token = res['token'];
    } else if (res['access_token'] != null) {
      token = res['access_token'];
    } else if (res['data'] != null && res['data']['token'] != null) {
      token = res['data']['token'];
    }

    // ✅ JIKA LOGIN BERHASIL → PINDAH HALAMAN
    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProfilePage(token: token!)),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(res['message'] ?? "Login gagal")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailC,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordC,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : login,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Login"),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterPage()),
              ),
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
