// tugas14.dart

import 'package:flutter/material.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter14/api/get_produk.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter14/model/produk_model.dart';

class Tugas14 extends StatefulWidget {
  const Tugas14({super.key});

  @override
  State<Tugas14> createState() => _Tugas14State();
}

class _Tugas14State extends State<Tugas14> {
  // Simpan semua produk dari API (tidak pernah diubah)
  List<DaftarProduk> _allProduk = [];

  // Daftar yang ditampilkan (berubah saat user mengetik)
  List<DaftarProduk> _filteredProduk = [];

  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Fetch data sekali saja saat widget pertama dibuka
  Future<void> _loadData() async {
    try {
      final data = await getUser();
      setState(() {
        _allProduk = data;
        _filteredProduk = data; // awalnya tampilkan semua
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  // Filter di memori, tanpa request API tambahan
  void _onSearchChanged(String query) {
    final keyword = query.toLowerCase();
    setState(() {
      _filteredProduk = _allProduk.where((produk) {
        final title = produk.title?.toLowerCase() ?? '';
        final category = produk.category?.toLowerCase() ?? '';
        return title.contains(keyword) || category.contains(keyword);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Produk")),
      body: Column(
        children: [
          // --- Search Bar ---
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Cari produk atau kategori...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // --- Konten Utama ---
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(child: Text("Terjadi kesalahan: $_errorMessage"));
    }

    if (_filteredProduk.isEmpty) {
      return const Center(child: Text("Produk tidak ditemukan"));
    }

    return ListView.builder(
      itemCount: _filteredProduk.length,
      itemBuilder: (context, index) {
        final item = _filteredProduk[index];

        return ListTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: Image.network(
              item.image ?? "",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image),
            ),
          ),
          title: Text(
            item.title ?? "Tanpa Nama",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Kategori: ${item.category}"),
              Text(
                "Harga: \$${item.price}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              Text(item.rating?.rate?.toString() ?? "0"),
            ],
          ),
        );
      },
    );
  }
}
