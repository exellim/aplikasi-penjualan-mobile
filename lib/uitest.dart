import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salessystem/materials/drawer.dart';
import 'package:salessystem/models/customerModel.dart';
import 'package:salessystem/network/api.dart';
import 'dart:convert';
import 'dart:async';
// import 'package:salessystem/pages/customer/addcustomer.dart';

class UiTester extends StatefulWidget {
  UiTester({
    Key? key,
  }) : super(key: key);

  @override
  State<UiTester> createState() => _UiTesterState();
}

class _UiTesterState extends State<UiTester> {
  final String url = 'customer';

  var _CustJson = [];

  void fetchCustomer() async {
    try {
      final response = await Network().getData(url);
      final jsonData = jsonDecode(response.body) as List;

      setState(() {
        _CustJson = jsonData;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    fetchCustomer();
  }

  @override
  Widget build(BuildContext context) {
    CustomerModel _customerModel;
    return Scaffold(
      drawer: Container(
          width: MediaQuery.of(context).size.width / 2 + 40,
          child: NavigationDrawerWidget()),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                color: Colors.green,
                child: Expanded(
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          "This is your List of customer!",
                          maxLines: 2,
                          textScaleFactor: 1,
                        ),
                      ),
                      Lottie.network(
                          "https://assets2.lottiefiles.com/packages/lf20_5zh17nif.json"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    // shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _CustJson.length,
                    itemBuilder: (context, index) {
                      final cust = _CustJson[index];
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Card(
                            elevation: 8,
                            child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText("${cust["nama"]}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.start,
                                          maxLines: 2),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text("${cust["alamat_rumah"]}",
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          textScaleFactor: 1),
                                      Text("${cust["handphone"]}",
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                          textScaleFactor: 1),
                                    ]))),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    fetchCustomer();
    return Future.delayed(Duration(seconds: 1));
  }
}
