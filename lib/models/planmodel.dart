import 'dart:convert';
import 'package:salessystem/network/api.dart';

/// userId : 1
/// id : 1
/// nama : "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
/// handphone : "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"

class PlanModel {
  PlanModel({
    int? id,
    String? nama,
    String? tanggal_tujuan,
    String? kunjungan_value,
    String? tujuan_value,
    String? jam_mulai,
    String? jam_selesai,
    String? catatan,
    String? created_at,
    String? updated_at,
    String? emp_number,
  }) {
    _id = id;
    _nama = nama;
    _tanggal_tujuan = tanggal_tujuan;
    _kunjungan_value = kunjungan_value;
    _tujuan_value = tujuan_value;
    _jam_mulai = jam_mulai;
    _jam_selesai = jam_selesai;
    _catatan = catatan;
    _created_at = created_at;
    _updated_at = updated_at;
    _emp_number = emp_number;
  }

  PlanModel.fromJson(dynamic json) {
    _id = json['id'];
    _nama = json['nama'];
    _tanggal_tujuan = json['tanggal_tujuan'];
    _kunjungan_value = json['kunjungan_value'];
    _tujuan_value = json['tujuan_value'];
    _jam_mulai = json['jam_mulai'];
    _jam_selesai = json['jam_selesai'];
    _catatan = json['catatan'];
    _created_at = json['created_at'];
    _updated_at = json['updated_at'];
    _emp_number = json['emp_number'];
  }
  int? _id;
  String? _nama;
  String? _tanggal_tujuan;
  String? _kunjungan_value;
  String? _tujuan_value;
  String? _jam_mulai;
  String? _jam_selesai;
  String? _catatan;
  String? _created_at;
  String? _updated_at;
  String? _emp_number;

  int? get id => _id;
  String? get nama => _nama;
  String? get tanggal_tujuan => _tanggal_tujuan;
  String? get kunjungan_value => _kunjungan_value;
  String? get tujuan_value => _tujuan_value;
  String? get jam_mulai => _jam_mulai;
  String? get jam_selesai => _jam_selesai;
  String? get catatan => _catatan;
  String? get created_at => _created_at;
  String? get updated_at => _updated_at;
  String? get emp_number => _emp_number;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nama'] = _nama;
    map['tanggal_tujuan'] = _tanggal_tujuan;
    map['kunjungan_value'] = _kunjungan_value;
    map['tujuan_value'] = _tujuan_value;
    map['jam_mulai'] = _jam_mulai;
    map['jam_selesai'] = _jam_selesai;
    map['catatan'] = _catatan;
    map['created_at'] = _created_at;
    map['updated_at'] = _updated_at;
    map['emp_number'] = _emp_number;
    return map;
  }
}

class PostPlan {
  String? nama;
  String? tanggal_tujuan;
  String? jam_mulai;
  String? jam_selesai;
  String? kunjungan_value;
  String? tujuan_value;
  String? catatan;
  String? emp_number;

  PostPlan({
    required this.nama,
    required this.tanggal_tujuan,
    required this.jam_mulai,
    required this.jam_selesai,
    required this.kunjungan_value,
    required this.tujuan_value,
    required this.catatan,
    required this.emp_number,
  });

  factory PostPlan.createPlanResult(Map<String, dynamic> object) {
    return PostPlan(
      nama: object['nama'],
      tanggal_tujuan: object['tanggal_tujuan'],
      jam_mulai: object['jam_mulai'],
      jam_selesai: object['jam_selesai'],
      kunjungan_value: object['kunjungan_value'],
      tujuan_value: object['tujuan_value'],
      catatan: object['catatan'],
      emp_number: object['emp_number'],
    );
  }

  static Future<PostPlan> sendData(
      String nama,
      String tanggal_tujuan,
      String jam_mulai,
      String jam_selesai,
      String tujuan_value,
      String kunjungan_value,
      String catatan,
      String emp_number) async {
    Map<String, dynamic> bodies = ({
      "nama": nama,
      "tanggal_tujuan": tanggal_tujuan,
      "jam_mulai": jam_mulai,
      "jam_selesai": jam_selesai,
      "kunjungan_value": kunjungan_value,
      "tujuan_value": tujuan_value,
      "catatan": catatan,
      "emp_number": emp_number
    });

    final String url = "kunjungan/add";
    print(bodies);
    var postResult = await Network().sendData(url, bodies);
    var jsonObject = jsonDecode(postResult.body);
    print(jsonObject);
    return PostPlan.createPlanResult(jsonObject);
  }
}
