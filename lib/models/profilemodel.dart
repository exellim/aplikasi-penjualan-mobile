import 'dart:convert';
import 'package:salessystem/network/api.dart';

class UserModel {
  // String id;
  String? name;
  String? img_url;
  String? emp_number;
  UserModel({this.name, this.img_url, this.emp_number});

  factory UserModel.createUser(Map<String, dynamic> object) {
    return UserModel(
      name: object['name'],
      img_url: object['img_url'],
      emp_number: object['emp_number'],
    );
  }

  static Future<UserModel> connectToApi(String url) async {
    final String url = "profile";

    var response = await Network().getData(url);
    var result = jsonDecode(response.body);
    var userData = (result as Map<String, dynamic>);

    return UserModel.createUser(userData);
  }
}
