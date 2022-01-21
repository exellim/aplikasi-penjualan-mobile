import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salessystem/models/customermodel.dart';
import 'package:salessystem/network/api.dart';

class CreatePlan extends StatefulWidget {
  CreatePlan({Key key}) : super(key: key);

  @override
  _CreatePlanState createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
  final formKey = GlobalKey<FormState>(); //key for form

  Future getCustomer() async {
    var response = Network().getData('customer');
    var body = jsonDecode(response.body);
    return body;
  }

  @override
  Widget build(BuildContext context) {
    String nama;
    TextEditingController TECnama = new TextEditingController();
    return Scaffold(
        appBar: AppBar(title: Text("Create Plan")),
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Center(
                child: Text("Create Plan",
                    textScaleFactor: 2.0,
                    style: TextStyle(fontWeight: FontWeight.bold)))
          ],
        ));
  }
}
