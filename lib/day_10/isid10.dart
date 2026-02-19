import 'package:flutter/material.dart';

class IsiD10 extends StatefulWidget {
  const IsiD10({super.key});

  @override
  State<IsiD10> createState() => _IsiD10State();
}

class _IsiD10State extends State<IsiD10> {
  int b = 0, c = 0;
  bool xx = true;
  void penjumlahanb() {
    b++;
  }

  void penguranganb() {
    b--;
  }

  void penjumlahanc() {
    c++;
  }

  void penguranganc() {
    c--;
  }

  void penjumlahanc3() {
    c += 3;
  }

  void menampilText() {
    xx = !xx;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$b', style: TextStyle(fontSize: 50)),
        ElevatedButton(
          onPressed: () {
            penjumlahanb();
            setState(() {});
          },
          child: Text('Tombol Penjumlahan'),
        ),
        ElevatedButton(
          onPressed: () {
            penguranganb();
            setState(() {});
          },
          child: Text('Tombol Pengurangan'),
        ),
        Divider(color: Colors.grey, thickness: 6),
        SizedBox(height: 30),
        GestureDetector(
          onTap: () {
            penjumlahanc();
            setState(() {});
          },
          onDoubleTap: () {
            penguranganc();
            setState(() {});
          },
          onLongPress: () {
            penjumlahanc3();
            setState(() {});
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(color: Colors.amber),
            child: Center(child: Text("$c", style: TextStyle(fontSize: 50))),
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Column(
            children: [
              Text('Ketuk sekali untuk penjumlahan +1'),
              Text('Ketuk sekali untuk pengurangan -1'),
              Text('Ketuk sekali untuk penjumlahan +3'),
            ],
          ),
        ),
        Divider(color: Colors.grey, thickness: 6),
        SizedBox(height: 10),
        InkWell(
          onTap: () {
            menampilText();
            setState(() {});
          },
          child: Image.asset('assets/images/tangan.png', height: 45),
        ),
        if (xx) Center(child: Text('Menampilkan Text')),
      ],
    );
  }
}
