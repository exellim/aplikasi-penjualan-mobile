import 'dart:convert';

ProdukModel produkModelFromJson(String str) =>
    ProdukModel.fromJson(json.decode(str));

String produkModelToJson(ProdukModel data) => json.encode(data.toJson());

class ProdukModel {
  ProdukModel({
    this.id,
    this.nama,
    this.deskripsi,
    this.harga,
    this.imgUrl,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String nama;
  String deskripsi;
  int harga;
  String imgUrl;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProdukModel.fromJson(Map<String, dynamic> json) => ProdukModel(
        id: json["id"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        harga: json["harga"],
        imgUrl: json["img_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "deskripsi": deskripsi,
        "harga": harga,
        "img_url": imgUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
