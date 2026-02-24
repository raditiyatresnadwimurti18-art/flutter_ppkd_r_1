import 'package:flutter/material.dart';

class CheckB7 extends StatefulWidget {
  const CheckB7({super.key});

  @override
  State<CheckB7> createState() => _CheckB7State();
}

bool xt7 = false;

class _CheckB7State extends State<CheckB7> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            children: [
              Text("terima syarat dan ketentuan"),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: xt7,
                    onChanged: (bool? newValue) {
                      setState(() {
                        xt7 = newValue ?? false;
                      });
                    },
                  ),

                  Expanded(
                    child: Text(
                      'Saya menyetujui semua persyaratan yang berlaku',
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              Text(xt7 ? 'anda menerima' : 'Anda belum bisa melanjutkan'),
            ],
          ),
        ),
      ],
    );
  }
}
