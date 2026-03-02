import 'package:flutter_ppkd_r_1/tugas_flutter11/database/sqflite.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/model/siswa_model.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter11/model/tugas11_model.dart';

class SiswaControler {
  static Future<void> registerUser(Tugas11Model siswa) async {
    final dbs = await DBHelper.db();
    await dbs.insert('siswa', siswa.toMap());
    print(siswa.toMap());
  }

  static Future<List<Tugas11Model>> getAllsiswa() async {
    final dbs = await DBHelper.db();
    final List<Map<String, dynamic>> result = await dbs.query("siswa");
    print(result.map((e) => Tugas11Model.fromMap(e)).toList());
    return result.map((e) => Tugas11Model.fromMap(e)).toList();
  }
}
