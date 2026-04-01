import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter15/api/api_service.dart';

class EditProfilePage extends StatefulWidget {
  final String token;
  final dynamic data;

  EditProfilePage({required this.token, required this.data});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameC.text = widget.data['name'];
    emailC.text = widget.data['email'];
  }

  void update() async {
    await ApiService.updateProfile(widget.token, nameC.text, emailC.text);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameC,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: emailC,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: update, child: Text("Update")),
          ],
        ),
      ),
    );
  }
}
