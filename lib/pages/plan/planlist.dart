// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:salessystem/materials/sidebar.dart';
import 'package:salessystem/pages/plan/createplan.dart';
import '../../network/api.dart';

class PlanList extends StatefulWidget {
  PlanList({Key key}) : super(key: key);

  @override
  _PlanListState createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  getPlan() async {
    return _getData();
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
        onPressed: () {
          _navigateToNextScreen(context);
        },
      ),
      body: FutureBuilder(
          future: getPlan(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text("Plan Finished: "),
                        Text(snapshot.data['data'].length.toString()),
                      ],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Card(
                            margin: EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        snapshot.data['data'][index]['nama'],
                                        textScaleFactor: 1.2,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Text(
                                                      "Kunjungan:",
                                                      style: TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data['data'][index]
                                                        ['tujuan_value'],
                                                    style: TextStyle(
                                                        fontSize: 14.0),
                                                  ),
                                                ]),
                                          ),
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Text(
                                                    'Kunjungan:',
                                                    style: TextStyle(
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                                Text(
                                                  snapshot.data['data'][index]
                                                      ['kunjungan_value'],
                                                  style:
                                                      TextStyle(fontSize: 14.0),
                                                ),
                                              ]),
                                        ],
                                      ),
                                      Text(
                                        snapshot.data['data'][index]
                                            ['tanggal_tujuan'],
                                        textScaleFactor: 1.2,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              );
            } else {
              return Text("No data received!");
            }
          }),
    );
  }
}

void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => CreatePlan()));
}

void _getData() async {
  var res = await Network().getData('kunjungan');
  var body = json.decode(res.body);
  return body;
}
