import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter6/home_t_6.dart';

class Login61 extends StatefulWidget {
  const Login61({super.key});

  @override
  State<Login61> createState() => _Login61State();
}

class _Login61State extends State<Login61> {
  bool x = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 34),
            Image.asset('assets/images/logof1.png', height: 300),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Email',
                      icon: Icon(Icons.email),
                    ),
                  ),
                  TextField(
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
                        icon: Icon(x ? Icons.visibility_off : Icons.visibility),
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
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomeT6()),
                          (Route) => false,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Masuk', style: TextStyle(color: Colors.white)),
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
          ],
        ),
      ),
    );
  }
}
