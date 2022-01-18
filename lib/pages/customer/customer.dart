import 'package:flutter/material.dart';
import 'package:salessystem/materials/sidebar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class CustomerList extends StatefulWidget {
  CustomerList({Key key}) : super(key: key);

  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  Future<List<Customer>> getCustomer() async {
    var data = await http.get(Uri.parse("http://127.0.0.1:8000/api/customer"));
    var jsonData = json.decode(data.body);

    List<Customer> Customers = [];

    for (var i in jsonData) {
      Customer customers =
          Customer(i['index'], i["nama"], i["alamat_rumah"], i["handphone"]);

      Customers.add(customers);
    }
    print(Customers.length);

    return Customers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List'),
      ),
      drawer: SideBar(),
      body: FutureBuilder(
          future: getCustomer(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                          ),
                          itemCount: snapshot.data["data"].length,
                          itemBuilder: (BuildContext context, int id) {
                            return GridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 2.0,
                              children: <Widget>[
                                Card(
                                  margin: EdgeInsets.all(10.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  elevation: 8,
                                  child: Column(
                                    children: <Widget>[
                                      Text(snapshot.data[id].nama),
                                      Text(snapshot.data[id].alamat_rumah),
                                      Text(snapshot.data[id].handphone),
                                    ],
                                  ),
                                )
                              ],
                            );
                          })),
                ],
              );
            } else {
              return Text('Connection problem');
            }
          }),
    );
  }
}

class Customer {
  final int id;
  final String nama;
  final String alamat_rumah;
  final String handphone;

  Customer(this.id, this.nama, this.alamat_rumah, this.handphone);
}
