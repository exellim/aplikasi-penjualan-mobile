import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:salessystem/materials/sidebar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class CustomerList extends StatelessWidget {
  const CustomerList({
    Key key,
  }) : super(key: key);

  final String url = 'http://127.0.0.1:8000/api/customer';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  // Future editProducts() async {
  //   var response = await http.get(Uri.parse(url + ""));
  //   return json.decode(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer List"),
      ),
      drawer: SideBar(),
      body: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        // crossAxisSpacing: 5.0,
                        // mainAxisSpacing: 2.0,
                      ),
                      itemCount: snapshot.data['data'].length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Card(
                            margin: EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            elevation: 5,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            snapshot.data['data'][index]
                                                ['nama'],
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                          ),
                                          Center(
                                            child: Text(
                                                snapshot.data['data'][index]
                                                        ['alamat_rumah']
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 8)),
                                          ),
                                          Text(
                                            snapshot.data['data'][index]
                                                ['handphone'],
                                            textAlign: TextAlign.center,
                                            textScaleFactor: 1.2,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              );
            } else {
              return Text("No data received!");
            }
          }),
    );
  }
}

// import '../../models/customermodels.dart';

// class CustomerList extends StatefulWidget {
//   CustomerList({Key key}) : super(key: key);

//   @override
//   _CustomerListState createState() => _CustomerListState();
// }

// class _CustomerListState extends State<CustomerList> {
  // Future<List<Customer>> getCustomer() async {
  //   var data = await http.get(Uri.parse("http://127.0.0.1:8000/api/customer"));
  //   var jsonData = json.decode(data.body);

  //   List<Customer> Customers = [];

  //   for (var i in jsonData) {
  //     Customer customers =
  //         Customer(i['index'], i["nama"], i["alamat_rumah"], i["handphone"]);

  //     Customers.add(customers);
  //   }
  //   print(Customers.length);

  //   return Customers;
  // }
//   getCustomer() async {
//     var response =
//         await http.get(Uri.parse("http://127.0.0.1:8000/api/customer"));
//     var jsondata = jsonDecode(response.body);

//     List<Customer> customers = [];
//     for (var i in jsondata) {
//       Customer customer =
//           Customer(i['id'], i['nama'], i['alamat_rumah'], i['handphone']);
//       customers.add(customer);
//     }
//     print(customers.length);
//     return customers;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Customer List'),
//       ),
//       drawer: SideBar(),
//       body: FutureBuilder(
//           future: getCustomer(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Flexible(
//                       child: GridView.builder(
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 5.0,
//                             mainAxisSpacing: 5.0,
//                           ),
//                           itemCount: snapshot.data.length,
//                           itemBuilder: (context, i) {
//                             return GridView.count(
//                               crossAxisCount: 2,
//                               mainAxisSpacing: 2.0,
//                               crossAxisSpacing: 2.0,
//                               children: <Widget>[
//                                 Card(
//                                   margin: EdgeInsets.all(10.0),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(25.0)),
//                                   elevation: 8,
//                                   child: Column(
//                                     children: <Widget>[
//                                       Text(snapshot.data[i].nama),
//                                       Text(snapshot.data[i].alamat_rumah),
//                                       Text(snapshot.data[i].handphone),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             );
//                           })),
//                 ],
//               );
//             } else {
//               return Text('Connection problem');
//             }
//           }),
//     );
//   }
// }

// class Customer {
//   final int id;
//   final String nama;
//   final String alamat_rumah;
//   final String handphone;

//   Customer(this.id, this.nama, this.alamat_rumah, this.handphone);
// }
