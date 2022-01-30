import 'package:flutter/material.dart';
import 'package:salessystem/materials/drawer.dart';
import 'package:salessystem/pages/takeorder/notafaktur.dart';

class Order extends StatefulWidget {
  Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order List"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NotaFaktur()));
        },
      ),
      drawer: Container(
          width: MediaQuery.of(context).size.width / 2 + 40,
          child: NavigationDrawerWidget()),
    );
  }
}
