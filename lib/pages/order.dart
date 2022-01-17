import 'package:flutter/material.dart';
import 'package:salessystem/materials/sidebar.dart';

class Order extends StatefulWidget {
  Order({Key key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
      ),
      drawer: SideBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Text("Order")),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Add Order");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
