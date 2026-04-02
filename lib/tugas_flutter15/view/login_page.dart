import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter15/api/auth_preferences.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter15/api/api_service.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter15/view/profil_page.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter15/view/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  // Validasi format email sederhana
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$').hasMatch(email);
  }

  // Ekstrak token dari berbagai format response API
  String? _extractToken(Map<String, dynamic> res) {
    if (res['token'] != null) return res['token'] as String?;
    if (res['access_token'] != null) return res['access_token'] as String?;
    final data = res['data'] as Map<String, dynamic>?;
    return data?['token'] as String?;
  }

  Future<void> _login() async {
    final email = _emailC.text.trim();
    final password = _passwordC.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("Email & Password wajib diisi");
      return;
    }

    if (!_isValidEmail(email)) {
      _showSnackBar("Format email tidak valid");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final res = await ApiService.login(email, password);
      final token = _extractToken(res);

      if (token != null) {
        await AuthPreferences.saveToken(token);

        if (!mounted) return;

        // Baca token dari storage, bukan dari parameter
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProfilePage()),
        );
      } else {
        if (!mounted) return;
        _showSnackBar(res['message'] as String? ?? "Login gagal");
      }
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _emailC.dispose();
    _passwordC.dispose();
    super.dispose();
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
              controller: _emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordC,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Password",
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : const Text("Login"),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterPage()),
              ),
              child: const Text("Belum punya akun? Register"),
            ),
          ],
        ),
      ),
    );
  }
}