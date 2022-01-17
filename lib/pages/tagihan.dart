import 'package:flutter/material.dart';
import 'package:salessystem/materials/sidebar.dart';

class Tagihan extends StatefulWidget {
  Tagihan({Key key}) : super(key: key);

  @override
  _TagihanState createState() => _TagihanState();
}

class _TagihanState extends State<Tagihan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tagihan"),
      ),
      drawer: SideBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Text("Tagihan Page")),
            ],
          ),
        ),
      ),
    );
  }
}
