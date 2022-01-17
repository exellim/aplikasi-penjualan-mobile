import 'package:flutter/material.dart';
import 'package:salessystem/pages/complaint.dart';
import 'package:salessystem/pages/home.dart';
import 'package:salessystem/pages/order.dart';
import 'package:salessystem/pages/reviewplan.dart';
import 'package:salessystem/pages/salesvisit.dart';
import 'package:salessystem/pages/tagihan.dart';

class SideBar extends StatefulWidget {
  SideBar({Key key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Column(
            children: [
              Container(
                height: 220,
                child: DrawerHeader(
                    child: Column(
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
                          color: Colors.indigo,
                        ),
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: Image.asset("/images/cp_logo.png"),
                        ),
                      ),
                    ),
                    Text(
                      "Username",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    Text(
                      "K0-1123",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )),
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
                MaterialPageRoute(builder: (context) => ReviewPlan()),
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
        ],
      ),
    );
  }
}
