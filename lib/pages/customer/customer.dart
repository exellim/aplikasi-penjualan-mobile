import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:salessystem/materials/sidebar.dart';
import 'package:http/http.dart' as http;
import 'package:salessystem/models/customerModel.dart';
import 'package:salessystem/network/api.dart';
import 'dart:convert';
import 'dart:async';
import 'package:salessystem/pages/customer/addcustomer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({
    Key key,
  }) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  String query = '';
  final String url = 'customer/';

  getCustomer() async {
    return _getData();
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
          actions: [],
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
        body: Container(
          child: FutureBuilder(
              future: getCustomer(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      padding: const EdgeInsets.all(10.0),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  snapshot.data['data'][index]['nama'],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  snapshot.data['data'][index]['alamat_rumah'],
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  snapshot.data['data'][index]['handphone'],
                                  textAlign: TextAlign.start,
                                  textScaleFactor: 1.2,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return SafeArea(
                    child: Center(
                        child: Container(
                      padding: const EdgeInsets.all(0.0),
                      width: 120.0,
                      height: 120.0,
                      child: Column(
                        children: [
                          SpinKitFadingCircle(
                            color: Colors.teal,
                          ),
                          Text('Loading...')
                        ],
                      ),
                    )),
                  );
                }
              }),
        ));
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddCustomer()));
  }
}

void _getData() async {
  var res = await Network().getData('customer');
  var body = json.decode(res.body);
  return body;
//  var res =  Network.getData('customer');
}

final spinkit = SpinKitFadingCircle(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.green,
      ),
    );
  },
);
