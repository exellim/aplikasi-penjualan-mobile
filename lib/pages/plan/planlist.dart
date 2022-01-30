import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:salessystem/materials/drawer.dart';
import 'package:salessystem/models/PlanModel.dart';
import 'package:salessystem/network/api.dart';
import 'dart:convert';

import 'package:salessystem/pages/plan/createplan.dart';

class PlanList extends StatefulWidget {
  PlanList({
    Key? key,
  }) : super(key: key);

  @override
  State<PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  final String url = 'kunjungan';

  var _ListPlan = [];

  void fetchPlan() async {
    try {
      final response = await Network().getData(url);
      final jsonData = jsonDecode(response.body) as List;

      setState(() {
        _ListPlan = jsonData;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();

    fetchPlan();
    print(_ListPlan.length);
  }

  @override
  Widget build(BuildContext context) {
    PlanModel plan = PlanModel();
    return Scaffold(
      drawer: Container(
          width: MediaQuery.of(context).size.width / 2 + 40,
          child: NavigationDrawerWidget()),
      appBar: AppBar(
        title: Text("Plan List"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreatePlan()));
        },
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
            itemCount: _ListPlan.length,
            itemBuilder: (context, index) {
              final plan = _ListPlan[index];
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
                              AutoSizeText("${plan["nama"]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 2),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                children: [
                                  Text("Ambil Order: ",
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      textScaleFactor: 1),
                                  SizedBox(width: 5),
                                  Text("${plan["kunjungan_value"]}",
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      textScaleFactor: 1),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Penagihan: ",
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      textScaleFactor: 1),
                                  SizedBox(width: 5),
                                  Text("${plan["tujuan_value"]}",
                                      maxLines: 2,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      textScaleFactor: 1),
                                ],
                              ),
                              Text("${plan["tanggal_tujuan"]}",
                                  maxLines: 2,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  textScaleFactor: 1),
                            ]))),
              );
            }),
      ),
    );
  }

  Future<void> _refresh() async {
    fetchPlan();
    return Future.delayed(Duration(seconds: 1));
  }
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
