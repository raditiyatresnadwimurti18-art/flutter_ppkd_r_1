// api/get_produk.dart

import 'dart:developer';
import 'package:flutter_ppkd_r_1/tugas_flutter14/model/produk_model.dart';
import 'package:http/http.dart' as http;

Future<List<DaftarProduk>> getUser() async {
  try {
    final response = await http.get(
      Uri.parse("https://fakestoreapi.com/products"),
    );

    if (response.statusCode == 200) {
      return daftarProdukFromJson(response.body);
    } else {
      throw Exception("Gagal memuat data: ${response.statusCode}");
    }
  } catch (e) {
    log("Error GetUser: $e");
    return [];
  }
}
