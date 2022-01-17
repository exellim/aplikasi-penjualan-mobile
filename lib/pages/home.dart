import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:salessystem/materials/sidebar.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home")),
      ),
      drawer: SideBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Card
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                            colors: [
                              Colors.green,
                              Color.fromARGB(255, 212, 233, 28)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                            ),
                            radius: 60.0,
                          ),
                          Column(
                            children: [
                              Text(
                                'John Doe',
                                textScaleFactor: 3.0,
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'SMT-01-22011',
                                textScaleFactor: 1.2,
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),

              // Body
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: Card(
                          child: Column(children: [
                            Text(
                              'Monthly Target',
                              textScaleFactor: 2.2,
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '12',
                              textScaleFactor: 1.2,
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(
                        child: Card(
                          child: Column(children: [
                            Center(
                              child: Text(
                                'Monthly Target',
                                textScaleFactor: 2.2,
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              '12',
                              textScaleFactor: 1.2,
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
