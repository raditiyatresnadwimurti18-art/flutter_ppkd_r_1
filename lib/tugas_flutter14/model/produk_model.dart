// model/produk_model.dart

import 'dart:convert';

List<DaftarProduk> daftarProdukFromJson(String str) => List<DaftarProduk>.from(
  json.decode(str).map((x) => DaftarProduk.fromJson(x)),
);

String daftarProdukToJson(List<DaftarProduk> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DaftarProduk {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  DaftarProduk({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory DaftarProduk.fromJson(Map<String, dynamic> json) => DaftarProduk(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    category: json["category"],
    image: json["image"],
    rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
    "rating": rating?.toJson(),
  };
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  factory Rating.fromJson(Map<String, dynamic> json) =>
      Rating(rate: json["rate"]?.toDouble(), count: json["count"]);

  Map<String, dynamic> toJson() => {"rate": rate, "count": count};
}
