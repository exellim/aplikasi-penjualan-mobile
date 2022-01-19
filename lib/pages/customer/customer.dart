import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:salessystem/materials/sidebar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'addcustomer.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({
    Key key,
  }) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  final String url = 'http://127.0.0.1:8000/api/customer';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
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
          createCustomer(context);
        },
      ),
      body: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
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
