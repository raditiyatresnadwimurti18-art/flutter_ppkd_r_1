import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter10/home_t_6.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter10/registert10.dart';

class Login61 extends StatefulWidget {
  const Login61({super.key});

  @override
  State<Login61> createState() => _Login61State();
}

class _Login61State extends State<Login61> {
  final TextEditingController emailControler = TextEditingController();
  final TextEditingController passwordontroler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool x = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/logof1.png', height: 300),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailControler,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tidak boleh kosong';
                        } else if (!value.contains('@')) {
                          return 'Harus mengandung @';
                        } else if (!value.contains('gmail.com')) {
                          return 'Email tidak valid';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                      ),
                    ),
                    TextFormField(
                      controller: passwordontroler,
                      validator: (value) {
                        // Masukkan logika validator dari poin #1 di sini
                        if (value == null || value.isEmpty) {
                          return 'Isi dulu bos!';
                        } else if (value.length < 8) {
                          return 'Kurang panjang (min 8)';
                        } else if (!value.contains(RegExp(r'[A-Z]'))) {
                          return 'Butuh huruf kapital';
                        } else if (!value.contains(RegExp(r'[0-9]'))) {
                          return 'Butuh angka';
                        } else {
                          return null;
                        }
                      },
                      obscureText: x,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        icon: Icon(Icons.password),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              x = !x;
                            });
                          },
                          icon: Icon(
                            x ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomeT6(text: "", text2: ""),
                              ),
                            );
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Masuk',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(Icons.chevron_right, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterT10(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            101,
                            157,
                            255,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(Icons.chevron_right, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Lupa password',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
