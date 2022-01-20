import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:salessystem/materials/sidebar.dart';

class PlanList extends StatefulWidget {
  PlanList({Key key}) : super(key: key);

  @override
  _PlanListState createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  final String url = 'http://127.0.0.1:8000/api/kunjungan';

  Future getPlan() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plan List"),
      ),
      drawer: SideBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {},
      ),
      body: FutureBuilder(
          future: getPlan(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Card(
                            margin: EdgeInsets.all(10.0),
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
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot.data['data'][index]
                                                ['nama'],
                                            textScaleFactor: 1.2,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data['data'][index]
                                                    ['tujuan']
                                                .toString(),
                                            textScaleFactor: 1.2,
                                          ),
                                          Text(
                                            snapshot.data['data'][index]
                                                ['tanggal_tujuan'],
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
