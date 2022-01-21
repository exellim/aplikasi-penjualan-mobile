import 'package:http/http.dart' as http;
import 'dart:convert';

PlanModel planModelFromJson(String str) => PlanModel.fromJson(json.decode(str));

String planModelToJson(PlanModel data) => json.encode(data.toJson());

class PlanModel {
    PlanModel({
        this.id,
        this.nama,
        this.tujuan,
        this.tanggalTujuan,
        this.jamMulai,
        this.jamSelesai,
        this.catatan,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String nama;
    String tujuan;
    DateTime tanggalTujuan;
    String jamMulai;
    dynamic jamSelesai;
    dynamic catatan;
    DateTime createdAt;
    DateTime updatedAt;

    factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
        id: json["id"],
        nama: json["nama"],
        tujuan: json["tujuan"],
        tanggalTujuan: DateTime.parse(json["tanggal_tujuan"]),
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        catatan: json["catatan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "tujuan": tujuan,
        "tanggal_tujuan": "${tanggalTujuan.year.toString().padLeft(4, '0')}-${tanggalTujuan.month.toString().padLeft(2, '0')}-${tanggalTujuan.day.toString().padLeft(2, '0')}",
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "catatan": catatan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}


class PostPlan {
  PostPlan({
        this.id,
        this.nama,
        this.tujuan,
        this.tanggalTujuan,
        this.jamMulai,
        this.jamSelesai,
        this.catatan,
    });

    int id;
    String nama;
    String tujuan;
    DateTime tanggalTujuan;
    String jamMulai;
    dynamic jamSelesai;
    dynamic catatan;

  factory PostPlan.createPostPlan(Map<String, dynamic> json) {
    return PostPlan(
        id: json["id"],
        nama: json["nama"],
        tujuan: json["tujuan"],
        tanggalTujuan: DateTime.parse(json["tanggal_tujuan"]),
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        catatan: json["catatan"],
    );
  }

  static Future<PostPlan> connectApi(
      String nama, String tujuan, String tanggalTujuan, String jamMulai, dynamic jamSelesai, dynamic catatan) async {
    String url = "http://127.0.0.1:8000/api/kunjungan/add";

    var result = await http.post(Uri.parse(url), body: {
      "nama": nama,
      "tujuan": tujuan,
      "tanggalTujuan": tanggalTujuan,
      "jamMulai": jamMulai,
      "jamSelesai": jamSelesai,
      "catatan": catatan,
    });
    var jsonObject = json.decode(result.body);

    return PostPlan.createPostPlan(jsonObject);
  }
}
