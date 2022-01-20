import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

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
