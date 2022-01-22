import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'http://127.0.0.1:8000/api/';
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
    print(token);
  }

  auth(data, apiURL) async {
    var fullUrl = _url + apiURL;
    print(token);
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  // sendData(data, apiURL) async {
  //   var fullUrl = _url + apiURL;
  //   print(token);
  //   return await http.post(Uri.parse(fullUrl),
  //       body: jsonEncode(data), headers: _setHeaders());
  // }

  getData(apiURL) async {
    var fullUrl = _url + apiURL;
    await _getToken();
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  sendData(apiURL, body) async {
    var fullUrl = _url + apiURL;
    await _getToken();
    print(token);
    return await http.post(Uri.parse(fullUrl),
        body: body, headers: {'Authorization': 'Bearer $token'});
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

  logOut(apiURL) async {
    var fullUrl = _url + apiURL;
    await _getToken();
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }
}
