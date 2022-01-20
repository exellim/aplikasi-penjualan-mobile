import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:salessystem/materials/sidebar.dart';
import 'package:http/http.dart' as http;
import 'package:salessystem/models/customerModel.dart';
import 'dart:convert';
import 'dart:async';
import 'package:salessystem/pages/customer/addcustomer.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({
    Key key,
  }) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  String query = '';
  final String url = 'http://127.0.0.1:8000/api/customer/';

  Future getCustomer() async {
    var response = await http.get(Uri.parse(url + query));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    CustomerModel _customerModel;
    TextEditingController namaController = TextEditingController();
    TextEditingController alamatController = TextEditingController();
    TextEditingController handphoneController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text("Customer List"),
        ),
        drawer: SideBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            _navigateToNextScreen(context);
          },
        ),
        resizeToAvoidBottomInset: true,
        body: FutureBuilder(
            future: getCustomer(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                  children:
                      List.generate(snapshot.data['data'].length, (index) {
                    return new Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 10,
                      child: new Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              snapshot.data['data'][index]['nama'],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Flexible(
                              child: Text(
                                snapshot.data['data'][index]['alamat_rumah'],
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              snapshot.data['data'][index]['handphone'],
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.2,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                );
              } else {
                return Text("No data received!");
              }
            }));
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddCustomer()));
  }
}

Future<CustomerModel> submitCustomer(
    String nama, String alamat_rumah, String handphone) async {
  final String url = 'http://127.0.0.1:8000/api/customer/add';
  var response = await http.post(Uri.parse(url), body: {
    "nama": nama,
    "alamat_rumah": alamat_rumah,
    "handphone": handphone,
  });
  var data = response.body;
  print(data);

  if (response.statusCode == 200) {
    String responseString = response.body;
    customerModelFromJson(responseString);
  } else {
    return null;
  }
}


