import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:salessystem/materials/drawer.dart';
import 'package:salessystem/network/api.dart';
import 'package:salessystem/pages/takeorder/notafaktur.dart';

class Order extends StatefulWidget {
  Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  var _notaJson = [];

  void fetchNota() async {
    try {
      final response = await Network().getData('nota');
      final jsonData = jsonDecode(response.body) as List;

      setState(() {
        _notaJson = jsonData;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    fetchNota();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order List"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NotaFaktur()));
        },
      ),
      drawer: Container(
          width: MediaQuery.of(context).size.width / 2 + 40,
          child: NavigationDrawerWidget()),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            color: Colors.green,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _notaJson.length,
                itemBuilder: (context, index) {
                  final nota = _notaJson[index];
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
                                  AutoSizeText("${nota["notaId"]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                      maxLines: 2),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  AutoSizeText("${nota["nama"]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                      maxLines: 2),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text("${nota["nomor_telfon"]}",
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      textScaleFactor: 1),
                                  Text("${nota["nama_produk"].length}",
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      textScaleFactor: 1),
                                ]))),
                  );
                }),
          )
        ],
      ),
    );
  }
}
