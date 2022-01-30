class NotaModel {
  String? custName;
  String? handphone;
  List<String>? produk;
  List<int>? jumlah;
  List<int>? harga;
  List<int>? subTotal;
  int? grandTotal;

  NotaModel(
      {this.custName,
      this.handphone,
      this.produk,
      this.jumlah,
      this.harga,
      this.subTotal,
      this.grandTotal});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

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
