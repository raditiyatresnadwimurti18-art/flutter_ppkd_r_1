// pages/detail_produk.dart

import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter14/model/produk_model.dart';

// Warna yang sama dengan tugas14.dart
const _kPrimaryColor = Color(0xfff71b64f); // AppBar biru
const _kAccentColor = Colors.green; // Harga, badge, tombol

class DetailProduk extends StatelessWidget {
  final DaftarProduk produk;

  const DetailProduk({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Detail Produk"),
        centerTitle: true,
        backgroundColor: _kPrimaryColor, // ← sama dengan tugas14
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Gambar Produk ---
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.grey[100],
              padding: const EdgeInsets.all(24),
              child: Image.network(
                produk.image ?? "",
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 80),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Kategori Badge ---
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors
                          .green[50], // ← sama dengan fillColor search bar
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _kAccentColor),
                    ),
                    child: Text(
                      produk.category?.toUpperCase() ?? "-",
                      style: const TextStyle(
                        color: _kAccentColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // --- Nama Produk ---
                  Text(
                    produk.title ?? "Tanpa Nama",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // --- Harga & Rating ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${produk.price}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _kAccentColor, // ← sama dengan harga di grid
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            "${produk.rating?.rate ?? 0}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "  (${produk.rating?.count ?? 0} ulasan)",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Divider(height: 32),

                  // --- Deskripsi ---
                  const Text(
                    "Deskripsi Produk",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    produk.description ?? "Tidak ada deskripsi.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- Tombol Beli ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Produk ditambahkan ke keranjang!"),
                            backgroundColor:
                                _kAccentColor, // ← hijau, sama dengan tema
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text(
                        "Tambah ke Keranjang",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _kPrimaryColor, // ← biru, sama dengan AppBar
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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
