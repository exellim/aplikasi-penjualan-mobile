import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:salessystem/network/api.dart';
// import 'dart:async';

CustomerModel customerModelFromJson(String str) =>
    CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  CustomerModel({
    this.id,
    this.nama,
    this.alamatRumah,
    this.handphone,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String nama;
  String alamatRumah;
  String handphone;
  DateTime createdAt;
  DateTime updatedAt;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["id"],
        nama: json["nama"],
        alamatRumah: json["alamat_rumah"],
        handphone: json["handphone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "alamat_rumah": alamatRumah,
        "handphone": handphone,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class PostCustomer {
  PostCustomer({
    this.id,
    this.nama,
    this.alamatRumah,
    this.handphone,
  });

  int id;
  String nama;
  String alamatRumah;
  String handphone;

  factory PostCustomer.createPostCustomer(Map<String, dynamic> json) {
    return PostCustomer(
        id: json["id"],
        nama: json["nama"],
        alamatRumah: json["alamat_rumah"],
        handphone: json["handphone"]);
  }

  static Future<PostCustomer> connectApi(
      String nama, String alamat_rumah, String handphone) async {
    final String url = 'customer/add';

    Map<String, dynamic> bodies = ({
      "nama": nama,
      "alamat_rumah": alamat_rumah,
      "handphone": handphone,
    });

    var result = Network().sendData(url, bodies);
    var jsonObject = json.decode(result.body);

    return PostCustomer.createPostCustomer(jsonObject);
  }
}
