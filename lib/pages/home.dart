import 'dart:ui';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:salessystem/materials/sidebar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../network_utils/api.dart';

class Home extends StatelessWidget {
  // const Home({Key? key}) : super(key: key);
  final String profile = 'http://127.0.0.1:8000/api/profile';

  // Future getData() async {
  //   var response = await http.get(Uri.parse(profile));
  //   // print(json.decode(json.encode(response.body)));
  //   return json.decode(json.encode(response.body));
  // }

  @override
  Widget build(BuildContext context) {
    Network().getData('/profile');
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: SideBar(),
      body: FutureBuilder(
          future: Network().getData('/profile'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.network(
                                        snapshot.data[0][index]['image_url']),
                                    Column(
                                      children: [
                                        Text(
                                          snapshot.data['data']['name'],
                                          textScaleFactor: 3.0,
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data['data']['emp_number'],
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
                                        'Address',
                                        textScaleFactor: 2.2,
                                        style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data['data']['address'],
                                        textScaleFactor: 1.0,
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
                                          'Phone',
                                          textScaleFactor: 2.2,
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data['data']['phone'],
                                        textScaleFactor: 1.0,
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
                    );
                  },
                ),
              );
            } else {
              // return Center(child: Text("No data received!"));
              return Container();
            }
          }),
    );
  }
}
