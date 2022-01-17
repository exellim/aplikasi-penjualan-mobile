import 'dart:math';

import 'package:flutter/material.dart';
import 'package:salessystem/materials/progresschart.dart';
import 'package:salessystem/materials/sidebar.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

final rng = Random();
const dayCount = 7;

class _HomeState extends State<Home> {
  List<Score> _scores;

  @override
  void initState() {
    super.initState();
    final scores = List<Score>.generate(dayCount, (index) {
      final y = rng.nextDouble() * 30.0;
      final m = DateTime.now().add(Duration(days: -dayCount + index));
      return Score(y, m);
    });
    setState(() {
      _scores = scores;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: SideBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 260.0,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 8.0,
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(height: 200, child: ProgressChart(_scores)),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Nama Toko
                                Expanded(
                                  child: Text(
                                    "Toko Karunia",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),

                                // Tanggal deadline
                                Expanded(
                                  child: Text(
                                    "28 Des",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
