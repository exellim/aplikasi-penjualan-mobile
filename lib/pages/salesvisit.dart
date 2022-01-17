import 'package:flutter/material.dart';
import 'package:salessystem/materials/sidebar.dart';

class SalesVisit extends StatefulWidget {
  SalesVisit({Key key}) : super(key: key);

  @override
  _SalesVisitState createState() => _SalesVisitState();
}

class _SalesVisitState extends State<SalesVisit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Visit"),
      ),
      drawer: SideBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Text("Sales Visit")),
            ],
          ),
        ),
      ),
    );
  }
}
