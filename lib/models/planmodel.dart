import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../network/api.dart';

PlanModel planModelFromJson(String str) => PlanModel.fromJson(json.decode(str));

String planModelToJson(PlanModel data) => json.encode(data.toJson());

class PlanModel {
  int id;
  String nama;
  String tujuan;
  DateTime tanggalTujuan;
  String jamMulai;
  dynamic jamSelesai;
  dynamic catatan;
  DateTime createdAt;
  DateTime updatedAt;

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
        "tanggal_tujuan":
            "${tanggalTujuan.year.toString().padLeft(4, '0')}-${tanggalTujuan.month.toString().padLeft(2, '0')}-${tanggalTujuan.day.toString().padLeft(2, '0')}",
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "catatan": catatan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class PostPlan {
  int id;
  String nama;
  String tujuan_value;
  String kunjungan_value;
  DateTime tanggalTujuan;
  String jamMulai;
  String jamSelesai;
  String catatan;
  String emp_number;

  PostPlan({
    this.id,
    this.nama,
    this.tujuan_value,
    this.kunjungan_value,
    this.tanggalTujuan,
    this.jamMulai,
    this.jamSelesai,
    this.catatan,
    this.emp_number,
  });

  factory PostPlan.createPostPlan(Map<String, dynamic> json) {
    return PostPlan(
      id: json["id"],
      nama: json["nama"],
      tujuan_value: json["tujuan_value"] ?? "no",
      kunjungan_value: json["kunjungan_value"] ?? "no",
      tanggalTujuan: DateTime.parse(json["tanggal_tujuan"]) ?? DateTime.now(),
      jamMulai: json["jam_mulai"] ?? TimeOfDay.now(),
      jamSelesai: json["jam_selesai"] ?? TimeOfDay.now(),
      catatan: json["catatan"] ?? "tidak ada catatan",
      emp_number: json["emp_number"],
    );
  }

  static Future<PostPlan> connectApi(
      String nama,
      String tanggalTujuan,
      String jamMulai,
      String jamSelesai,
      String catatan,
      String kunjungan_value,
      String tujuan_value,
      String emp_number) async {
    final String url = 'kunjungan/add';

    Map<String, dynamic> bodies = ({
      "nama": nama,
      "tanggal_tujuan": tanggalTujuan,
      "jam_mulai": jamMulai,
      "jam_selesai": jamSelesai,
      "catatan": catatan,
      "kunjungan_value": kunjungan_value,
      "tujuan_value": tujuan_value,
      "emp_number": emp_number,
    });
    var result = Network().sendData(url, bodies);
    var jsonObject = json.decode(result.body);

    return PostPlan.createPostPlan(jsonObject);
  }
}
