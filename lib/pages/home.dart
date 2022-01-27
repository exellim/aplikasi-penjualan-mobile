import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salessystem/materials/sidebar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salessystem/pages/account/login.dart';
import 'package:salessystem/pages/customer/customer.dart';
import 'package:salessystem/pages/order.dart';
import 'package:salessystem/pages/plan/planlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // const Home({Key? key}) : super(key: key);
  final String profile = 'http://127.0.0.1:8000/api/profile';

  // Future getData() async {
  @override
  Widget build(BuildContext context) {
    // Network().getData('/profile');
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: () {
                logout();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            )
          ],
        ),
        drawer: SideBar(),
        body: Column(
          children: [
            SafeArea(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.grey),
                        height: 500,
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(child: Text("Graph container")),
                            Expanded(child: Text("Graph container")),
                            Expanded(child: Text("Graph container")),
                            Expanded(child: Text("Graph container")),
                            Expanded(child: Text("Graph container")),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        color: Colors.grey,
                      ),
                      // buatKotak(Colors.greenAccent, 400),
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              color: Colors.teal.shade300,
                              padding: EdgeInsets.all(20),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlanList()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.event_note,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  Divider(thickness: 2, color: Colors.white),
                                  Text(
                                    "Review Plan",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              color: Colors.teal.shade700,
                              padding: EdgeInsets.all(20),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CustomerList()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  Divider(thickness: 2, color: Colors.white),
                                  Text(
                                    "Customers\n",
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              color: Colors.teal,
                              padding: EdgeInsets.all(20),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Order()),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.post_add_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  Divider(thickness: 2, color: Colors.white),
                                  Text(
                                    "Order\n",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
          ],
        ));
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if (body['message'] ==
        'You have successfully logged out and the token was successfully deleted') {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Login()));
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (BuildContext context) => Login()));

    }
  }

  Widget buatKotak(Color warna, double ukuran) {
    return Container(
      decoration: BoxDecoration(color: warna),
      height: ukuran,
      width: ukuran,
      margin: EdgeInsets.all(10),
    );
  }
}
