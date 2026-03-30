// helper/search_translator.dart

/// Menerjemahkan kata kunci Bahasa Indonesia ke Bahasa Inggris
/// agar cocok dengan data dari fakestoreapi.com
String translateQuery(String query) {
  final keyword = query.toLowerCase().trim();

  // Cek dulu apakah ada terjemahan persis di kamus
  if (_dictionary.containsKey(keyword)) {
    return _dictionary[keyword]!;
  }

  // Jika tidak ada yang persis, cek apakah query mengandung salah satu kata kunci
  for (final entry in _dictionary.entries) {
    if (keyword.contains(entry.key)) {
      // Ganti bagian yang cocok dengan terjemahannya
      return keyword.replaceAll(entry.key, entry.value);
    }
  }

  // Kalau tidak ada di kamus, kembalikan apa adanya (mungkin sudah Bahasa Inggris)
  return keyword;
}

const Map<String, String> _dictionary = {
  // --- Kategori utama fakestoreapi ---
  'elektronik': 'electronics',
  'perhiasan': 'jewelery',
  'pakaian pria': "men's clothing",
  'pakaian wanita': "women's clothing",
  'baju pria': "men's clothing",
  'baju wanita': "women's clothing",

  // --- Pakaian umum ---
  'pakaian': 'clothing',
  'baju': 'clothing',
  'kaos': 't-shirt',
  'kemeja': 'shirt',
  'jaket': 'jacket',
  'celana': 'pants',
  'rok': 'skirt',
  'gaun': 'dress',
  'sweater': 'sweater',
  'hoodie': 'hoodie',
  'pria': "men",
  'wanita': "women",
  'laki': "men",
  'perempuan': "women",

  // --- Perhiasan ---
  'kalung': 'necklace',
  'cincin': 'ring',
  'gelang': 'bracelet',
  'anting': 'earring',
  'jam': 'watch',
  'emas': 'gold',
  'perak': 'silver',

  // --- Elektronik ---
  'laptop': 'laptop',
  'komputer': 'computer',
  'handphone': 'phone',
  'hp': 'phone',
  'kabel': 'cable',
  'monitor': 'monitor',
  'hard disk': 'hard drive',
  'memori': 'memory',
  'baterai': 'battery',
  'kamera': 'camera',
  'headphone': 'headphone',
  'earphone': 'earphone',

  // --- Kata sifat umum ---
  'murah': 'cheap',
  'mahal': 'expensive',
  'bagus': 'good',
  'baru': 'new',
  'putih': 'white',
  'hitam': 'black',
  'merah': 'red',
  'biru': 'blue',
  'hijau': 'green',
  'kuning': 'yellow',
};
