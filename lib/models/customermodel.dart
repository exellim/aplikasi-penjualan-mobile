/// userId : 1
/// id : 1
/// nama : "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
/// handphone : "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"

class CustomerModel {
  CustomerModel({
    int? id,
    String? nama,
    String? alamat_rumah,
    String? handphone,
  }) {
    _id = id;
    _nama = nama;
    _alamat_rumah = alamat_rumah;
    _handphone = handphone;
  }

  CustomerModel.fromJson(dynamic json) {
    _id = json['id'];
    _nama = json['nama'];
    _alamat_rumah = json['alamat_rumah'];
    _handphone = json['handphone'];
  }
  int? _id;
  String? _nama;
  String? _alamat_rumah;
  String? _handphone;

  int? get id => _id;
  String? get nama => _nama;
  String? get alamat_rumah => _alamat_rumah;
  String? get handphone => _handphone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['nama'] = _nama;
    map['alamat_rumah'] = _alamat_rumah;
    map['handphone'] = _handphone;
    return map;
  }
}
