// import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
        body: Container(
          child: FutureBuilder(
              future: getPlan(),
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
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Kunjungan:",
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          snapshot.data['data'][index]
                                              ['kunjungan_value'],
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Penagihan:",
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          snapshot.data['data'][index]
                                              ['tujuan_value'],
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  snapshot.data['data'][index]
                                      ['tanggal_tujuan'],
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
