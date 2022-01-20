import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:salessystem/materials/sidebar.dart';
import 'package:http/http.dart' as http;
import 'package:salessystem/models/customerModel.dart';
import 'dart:convert';
import 'dart:async';

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
        onPressed: () {},
      ),
      body: FutureBuilder(
          future: getCustomer(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 8.0, left: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Search Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.red),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      onChanged: (value) {
                        setState(() {
                          query = value;
                        });
                      },
                    ),
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // crossAxisSpacing: 5.0,
                        // mainAxisSpacing: 2.0,
                      ),
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Card(
                            margin: EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            elevation: 5,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10.0),
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            snapshot.data['data'][index]
                                                ['nama'],
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                          ),
                                          Text(
                                              snapshot.data['data'][index]
                                                      ['alamat_rumah']
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 8)),
                                          Text(
                                            snapshot.data['data'][index]
                                                ['handphone'],
                                            textAlign: TextAlign.center,
                                            textScaleFactor: 1.2,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              );
            } else {
              return Text("No data received!");
            }
          }),
    );
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
