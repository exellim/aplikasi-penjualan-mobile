import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:salessystem/materials/sidebar.dart';
import 'package:salessystem/materials/drawer.dart';
import 'package:salessystem/pages/account/login.dart';
import 'package:salessystem/pages/homepage.dart';
// import 'package:salessystem/pages/order.dart';
// import 'package:salessystem/pages/plan/planlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final String profile = 'http://127.0.0.1:8000/api/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
          width: MediaQuery.of(context).size.width / 2 + 40,
          child: NavigationDrawerWidget()),
      appBar: AppBar(
        title: Text("Home"),
        // title: Text((title == null) ? "Home" : title.toString()),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
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
      // drawer: SideBar(),
      // body: pages[indexPage],
      body: HomePage(),
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
    }
  }
}
