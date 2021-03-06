import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salessystem/materials/drawer.dart';
import 'package:salessystem/models/customerModel.dart';
import 'package:salessystem/network/api.dart';
import 'dart:convert';
import 'dart:async';
// import 'package:salessystem/pages/customer/addcustomer.dart';

class CustomerList extends StatefulWidget {
  CustomerList({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
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
      appBar: AppBar(
        title: Text("Customer List"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.8,
              // color: Colors.green,
              child: 
                  Stack(
                    children: [
                      Column(
                children: [
                  Stack(
                    children: [
                      Expanded(child: Text("Customer Page",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                    ],
                  ),
                      Lottie.network('https://assets3.lottiefiles.com/packages/lf20_sdhrtxpw.json')
                    ],
                  ),
                ],
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }

  Future<void> _refresh() async {
    fetchCustomer();
    return Future.delayed(Duration(seconds: 1));
  }
}
