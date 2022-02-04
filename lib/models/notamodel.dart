import 'dart:convert';

import 'package:salessystem/network/api.dart';

class NotaModel {
  int? id;
  String? custName;
  String? handphone;
  List<String>? produk;
  List<int>? jumlah;
  List<int>? harga;
  List<int>? subTotal;
  int? grandTotal;

  NotaModel(
      {this.id,
      this.custName,
      this.handphone,
      this.produk,
      this.jumlah,
      this.harga,
      this.subTotal,
      this.grandTotal});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['cust_name'] = custName;
    data['handphone'] = handphone;
    data['produk'] = produk;
    data['jumlah'] = jumlah;
    data['harga'] = harga;
    data['subTotal'] = subTotal;
    data['grandTotal'] = grandTotal;

    return data;
  }
}

class PostNota {
  String? notaId;
  String? custName;
  String? handphone;
  List<String>? produk;
  List<int>? jumlah;
  List<int>? harga;
  List<int>? subTotal;

  PostNota({
    this.notaId,
    this.custName,
    this.handphone,
    this.produk,
    this.jumlah,
    this.harga,
    this.subTotal,
  });

  factory PostNota.createPlanResult(Map<String, dynamic> object) {
    return PostNota(
        notaId: object['notaId'],
        custName: object['nama'],
        handphone: object['nomor_telfon'],
        produk: object['nama_produk'],
        jumlah: object['qty_produk'],
        subTotal: object['subtotal_harga']);
  }

  static Future<PostNota> sendData(
    String notaId,
    String custName,
    String handphone,
    List<String> produk,
    List<int> jumlah,
    List<int> harga,
    List<int> subTotal,
  ) async {
    Map<String, dynamic> bodies = ({
      "notaId": notaId,
      "nama": custName,
      "nomor_telfon": handphone,
      "nama_produk": produk,
      "qty_produk": jumlah,
      "harga_produk": harga,
      "subtotal_harga": subTotal,
    });
    final String url = "nota/add";
    print(bodies);
    var postResult = await Network().sendDataJson(url, bodies);
    var jsonObject = jsonDecode(postResult.body);
    print(jsonObject);
    return PostNota.createPlanResult(jsonObject);
  }
}
