import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter15/api/auth_preferences.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter15/api/api_service.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter15/model/user_model.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel user;

  // Token tidak lagi diteruskan via parameter — dibaca dari secure storage
  const EditProfilePage({
    super.key,
    required this.user,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameC;
  late TextEditingController _emailC;

  bool _isLoading = false;

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w.-]+@[\w.-]+\.\w{2,}$').hasMatch(email);
  }

  @override
  void initState() {
    super.initState();
    _nameC = TextEditingController(text: widget.user.name);
    _emailC = TextEditingController(text: widget.user.email);
  }

  Future<void> _update() async {
    final name = _nameC.text.trim();
    final email = _emailC.text.trim();

    if (name.isEmpty || email.isEmpty) {
      _showSnackBar("Field tidak boleh kosong");
      return;
    }

    if (!_isValidEmail(email)) {
      _showSnackBar("Format email tidak valid");
      return;
    }

    // Cek apakah ada perubahan
    if (name == widget.user.name && email == widget.user.email) {
      _showSnackBar("Tidak ada perubahan");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final token = await AuthPreferences.getToken();
      if (token == null) throw Exception('Sesi habis, silakan login kembali');

      final res = await ApiService.updateProfile(token, name, email);

      if (!mounted) return;

      if (res['success'] == true || res['data'] != null) {
        _showSnackBar("Update berhasil");
        Navigator.pop(context);
      } else {
        _showSnackBar(res['message'] as String? ?? "Update gagal");
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
    _nameC.dispose();
    _emailC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameC,
              decoration: const InputDecoration(
                labelText: "Nama",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _update,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : const Text("Update"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}