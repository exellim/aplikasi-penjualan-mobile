class NotaFakturModel {
  String no_nota;
  String emp_number;
  String tipe_pembayaran;
  String bukti;
  List<String> produk = [];

  NotaFakturModel({this.no_nota,this.emp_number,this.tipe_pembayaran,this.bukti, this.produk});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['no_nota'] = this.no_nota;
    data['emp_number'] = this.emp_number;
    data['tipe_pembayaran'] = this.tipe_pembayaran;
    data['bukti'] = this.bukti;
    data['produk'] = this.produk;


    return data;
  }
}