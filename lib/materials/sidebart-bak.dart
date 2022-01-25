import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salessystem/pages/complaint.dart';
import 'package:salessystem/pages/customer/customer.dart';
import 'package:salessystem/pages/home.dart';
import 'package:salessystem/pages/order.dart';
import 'package:salessystem/pages/plan/planlist.dart';
import 'package:salessystem/pages/reviewplan.dart';
import 'package:salessystem/pages/salesvisit.dart';
import 'package:salessystem/pages/tagihan.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api.dart';
import '../pages/account/login.dart';

class SideBar extends StatefulWidget {
  SideBar({Key key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Future<String> _getEmp() async {
    await Network().getData('profile').then((response) {
      var body = json.decode(response.body);

      return body;
    });
  }

  String emp_number;
  String nama;
  var img_url;

  @override
  void initState() {
    super.initState();
    _getEmp();
  }

  @override
  Widget build(BuildContext context) {
    // _getEmp();
    // print("nama: ${nama}");
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Container(
                  height: 220,
                  child: DrawerHeader(child: Builder(builder: (context) {
                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            width: double.infinity,
                            // height: 200.0,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3))
                              ],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(225.0),
                                bottomRight: Radius.circular(225.0),
                              ),
                              color: Colors.teal,
                            ),
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              // child: Image.network(img_url),
                            ),
                          ),
                        ),
                        Text(
                          "nama",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Text(
                          "emp_number",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  })),
                ),
              ],
            ),

            // Home Page
            ListTile(
              title: Text("Home"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),

            // Review Plan
            ListTile(
              title: Text("Review Plan"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanList()),
                );
              },
            ),

            // Customer
            ListTile(
              title: Text("Customer"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerList()),
                );
              },
            ),

            // Order
            ListTile(
              title: Text("Order"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Order()),
                );
              },
            ),

            // Tagihan
            ListTile(
              title: Text("Tagihan"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Tagihan()),
                );
              },
            ),

            // Complaint
            ListTile(
              title: Text("Complaint"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Complaint()),
                );
              },
            ),

            // SalesVisit
            ListTile(
              title: Text("Sales Visit"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SalesVisit()),
                );
              },
            ),

            // Logout
            ListTile(
              title: Row(
                children: [
                  Text("LogOut"),
                  Icon(Icons.logout_sharp),
                ],
              ),
              onTap: () {
                logout();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        ),
      ),
    );
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if (body['message'] ==
        'You have successfully logged out and the token was successfully deleted') {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}