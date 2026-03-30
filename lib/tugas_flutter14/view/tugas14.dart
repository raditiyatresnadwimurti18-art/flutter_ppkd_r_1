import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'; // Import slider
import 'package:flutter_ppkd_r_1/tugas_flutter14/api/get_produk.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter14/helper/search_translator.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter14/model/produk_model.dart';
import 'package:flutter_ppkd_r_1/tugas_flutter14/view/detail_produk.dart';

class Tugas14 extends StatefulWidget {
  const Tugas14({super.key});

  @override
  State<Tugas14> createState() => _Tugas14State();
}

class _Tugas14State extends State<Tugas14> {
  List<DaftarProduk> _allProduk = [];
  List<DaftarProduk> _filteredProduk = [];
  bool _isLoading = true;
  String? _errorMessage;
  final TextEditingController _searchController = TextEditingController();

  // 7 Link Gambar Landscape Produk
  final List<String> _bannerImages = [
    "https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=1000&auto=format&fit=crop", // Fashion Store
    "https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=1000&auto=format&fit=crop", // Watch/Gadget
    "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=1000&auto=format&fit=crop", // Electronics/Headphone
    "https://images.unsplash.com/photo-1483985988355-763728e1935b?q=80&w=1000&auto=format&fit=crop", // Shopping Bags
    "https://images.unsplash.com/photo-1491336477066-31156b5e4f35?q=80&w=1000&auto=format&fit=crop", // Men Fashion
    "https://images.unsplash.com/photo-1601121141461-9d6647bca1ed?q=80&w=1000&auto=format&fit=crop", // Jewelry
    "https://images.unsplash.com/photo-1460353581641-37baddab0fa2?q=80&w=1000&auto=format&fit=crop", // Sneakers
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final data = await getUser();
      setState(() {
        _allProduk = data;
        _filteredProduk = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    final translated = translateQuery(query);
    final keyword = translated.toLowerCase();
    setState(() {
      _filteredProduk = _allProduk.where((produk) {
        final title = produk.title?.toLowerCase() ?? '';
        final category = produk.category?.toLowerCase() ?? '';
        return title.contains(keyword) || category.contains(keyword);
      }).toList();
    });
  }

  void _showGeminiAISheet(BuildContext context) {
    final TextEditingController aiController = TextEditingController();
    final TextEditingController budgetController =
        TextEditingController(); // Controller baru

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.auto_awesome, color: Color(0xFF1B66C9)),
                  SizedBox(width: 10),
                  Text(
                    "Gemini Shopping Assistant",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Input Kondisi
              const Text(
                "Apa yang kamu cari?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: aiController,
                decoration: InputDecoration(
                  hintText: "Contoh: Baju untuk lari pagi...",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Input Budget
              const Text(
                "Budget Maksimal (\$)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: budgetController,
                keyboardType: TextInputType.number, // Hanya angka
                decoration: InputDecoration(
                  hintText: "Contoh: 50",
                  prefixText: "\$ ",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B66C9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Kirim kedua data ke fungsi pemroses
                    double? maxPrice = double.tryParse(budgetController.text);
                    _processAIWithBudget(aiController.text, maxPrice);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cari Sesuai Budget",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _processAIWithBudget(String userInput, double? maxPrice) {
    String keyword = userInput.toLowerCase();
    String categoryTarget = "";

    // 1. Mapping Kategori (Sama seperti sebelumnya)
    if (keyword.contains("pesta") || keyword.contains("perhiasan")) {
      categoryTarget = "jewelery";
    } else if (keyword.contains("olahraga") || keyword.contains("pria")) {
      categoryTarget = "men's clothing";
    } else if (keyword.contains("elektronik") || keyword.contains("gadget")) {
      categoryTarget = "electronics";
    } else if (keyword.contains("wanita") || keyword.contains("cewek")) {
      categoryTarget = "women's clothing";
    }

    setState(() {
      _filteredProduk = _allProduk.where((produk) {
        // Filter Berdasarkan Kategori (jika ditemukan) atau Judul
        bool matchCategory = categoryTarget.isEmpty
            ? (produk.title?.toLowerCase().contains(keyword) ?? false)
            : (produk.category?.toLowerCase() == categoryTarget);

        // Filter Berdasarkan Budget (jika diisi)
        bool matchPrice =
            (maxPrice == null) ||
            (produk.price != null && produk.price! <= maxPrice);

        return matchCategory && matchPrice;
      }).toList();

      // Update teks di search bar agar user tahu apa yang sedang difilter
      _searchController.text = userInput;
    });

    // Notifikasi Feedback
    String message = maxPrice != null
        ? "Menampilkan hasil untuk '$userInput' di bawah \$$maxPrice"
        : "Menampilkan hasil untuk '$userInput'";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF1B66C9),
        content: Text(message),
      ),
    );
  }

  void _processAIRecommendation(String userInput) {
    String keyword = userInput.toLowerCase();
    String filterResult = "";

    // Logika Pemetaan Sederhana (Simulasi Berpikir AI)
    if (keyword.contains("pesta") ||
        keyword.contains("mewah") ||
        keyword.contains("kado istri")) {
      filterResult = "jewelery";
    } else if (keyword.contains("olahraga") ||
        keyword.contains("lari") ||
        keyword.contains("pria")) {
      filterResult = "men's clothing";
    } else if (keyword.contains("kerja") ||
        keyword.contains("kantor") ||
        keyword.contains("wanita")) {
      filterResult = "women's clothing";
    } else if (keyword.contains("gadget") ||
        keyword.contains("elektronik") ||
        keyword.contains("hp") ||
        keyword.contains("laptop")) {
      filterResult = "electronics";
    } else {
      // Jika tidak ada kata kunci yang cocok, gunakan input user langsung
      filterResult = userInput;
    }

    // Update Search Bar dan Filter Produk
    _searchController.text = filterResult;
    _onSearchChanged(filterResult);

    // Berikan feedback ke user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF1B66C9),
        content: Text("AI merekomendasikan produk untuk: '$filterResult'"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Toko Maniak",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff71b64f),
      ),
      body: Column(
        children: [
          // 1. Kolom Pencarian
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Cari produk...',
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                filled: true,
                fillColor: Colors.green[50],
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.green, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          // 2. Slider Banner (Hanya muncul jika tidak sedang mencari atau hasil ada)
          if (_searchController.text.isEmpty)
            CarouselSlider(
              options: CarouselOptions(
                height: 160.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.85,
              ),
              items: _bannerImages.map((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

          const SizedBox(height: 15),

          // 3. Grid Produk
          Expanded(
            child: RefreshIndicator(onRefresh: _loadData, child: _buildBody()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showGeminiAISheet(context);
        },
        label: const Text(
          "Tanya AI Gemini",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.auto_awesome, color: Colors.white),
        backgroundColor: const Color(0xFF1B66C9), // Biru khas Gemini
        elevation: 4,
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_errorMessage != null)
      return Center(child: Text("Error: $_errorMessage"));
    if (_filteredProduk.isEmpty)
      return const Center(child: Text("Produk tidak ditemukan"));

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _filteredProduk.length,
      itemBuilder: (context, index) {
        final item = _filteredProduk[index];
        return GestureDetector(
          // ← tambahan
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailProduk(produk: item),
              ),
            );
          },
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(item.image ?? "", fit: BoxFit.contain),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${item.price}",
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                                Text(
                                  "${item.rating?.rate ?? 0}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
