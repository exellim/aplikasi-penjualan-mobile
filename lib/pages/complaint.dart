import 'package:flutter/material.dart';
import 'package:salessystem/materials/sidebar.dart';

class Complaint extends StatefulWidget {
  Complaint({Key key}) : super(key: key);

  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint"),
      ),
      drawer: SideBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Text("Complaint Page")),
            ],
          ),
        ),
      ),
    );
  }
}
