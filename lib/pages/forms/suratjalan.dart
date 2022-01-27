import 'dart:convert';
// import 'package:dropdownfield/dropdownfield.dart';

import 'package:flutter/material.dart';
import 'package:salessystem/models/notafaktur.dart';
import 'package:salessystem/network/api.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class SuratJalan extends StatefulWidget {
  SuratJalan({Key key}) : super(key: key);

  @override
  State<SuratJalan> createState() => _SuratJalanState();
}

class _SuratJalanState extends State<SuratJalan> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  NotaFakturModel notaFakturModel = NotaFakturModel();

  List<ProductForm> listProduct = [];
  List<String> data = [];

  TextEditingController no_nota = TextEditingController();

  String noNota, namaCustomer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNama();
    SendData();
  }

  Icon floatingIcon = new Icon(Icons.add);

  addProduct() {
    // listProduct.add(ProductForm());
    // setState(() {});
    if (data.length != 0) {
      floatingIcon = new Icon(Icons.add);

      data = [];
      listProduct = [];
      print('if');
    }
    setState(() {});
    listProduct.add(new ProductForm());
  }

  SendData() {
    // data = [];
    // listProduct.forEach((widget) => print(widget.controller.text));
    // listProduct.forEach((widget) => data.add(widget.controller.text));
    // // listProduct.forEach((widget) => listProduct.addAll(widget.controller));

    floatingIcon = new Icon(Icons.arrow_back);
    data = [];
    listProduct.forEach((widget) => data.add(widget.controller.text));
    setState(() {});
    print(data.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buat Nota"),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: addProduct, child: Icon(Icons.add)),
      body: formWidget(),
    );
  }
  //  formWidget(),

  Widget formWidget() {
    return Form(
      key: globalKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                // FormHelper.inputFieldWidgetWithLabel(
                //     context,
                //     Icon(Icons.description_rounded),
                //     "nota",
                //     "No Nota",
                //     "SJ-xxxx", (onValidateVal) {
                //   if (onValidateVal.isEmpty) {
                //     return 'No nota harus di isi';
                //   }
                //   return null;
                // }, (onSavedVal) {
                //   this.notaFakturModel.no_nota = onSavedVal;
                // },
                //     initialValue: notaFakturModel.no_nota ?? "",
                //     borderColor: Colors.grey,
                //     borderFocusColor: Colors.teal,
                //     borderRadius: 8.0,
                //     fontSize: 14.0,
                //     labelFontSize: 14.0,
                //     paddingLeft: 0,
                //     paddingRight: 0),
                Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 8, left: 8),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Nomor Nota harus terisi";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'No. Nota',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.teal),
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onChanged: (value) {
                      setState(() {
                        noNota = value;
                      });
                    },
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.only(top: 10, bottom: 10, right: 8, left: 8),
                    child: Container(
                      // padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(style: BorderStyle.solid)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                value: nama,
                                iconSize: 30,
                                icon: (null),
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                                hint: Text('Pilih Customer'),
                                onChanged: (String newValue) {
                                  setState(() {
                                    nama = newValue;
                                    namaCustomer = nama;
                                    _getNama();
                                    // print();
                                    print(data);
                                  });
                                },
                                items: namaList?.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['nama']),
                                        value: item['nama'].toString(),
                                      );
                                    })?.toList() ??
                                    [],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: listProduct.length,
                    itemBuilder: (_, index) => listProduct[index]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        color: Colors.teal,
                        padding: EdgeInsets.all(20),
                        onPressed: () {
                          print(noNota + '\n' + namaCustomer + '\n');
                          // SendData();
                          // listProduct = SendData();
                          SendData();
                          print(data);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.check,
                              size: 25,
                              color: Colors.white,
                            ),
                            Text("Submit")
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        color: Colors.red,
                        padding: EdgeInsets.all(20),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.cancel,
                              size: 25,
                              color: Colors.white,
                            ),
                            Text("Batal")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String url = 'customer';
  List namaList;
  String nama;
  Future<String> _getNama() async {
    await Network().getData(url).then((response) {
      var data = json.decode(response.body);

      setState(() {
        namaList = data['data'];
      });
    });
  }
}

class ProductForm extends StatelessWidget {
  ProductForm({Key key}) : super(key: key);

  TextEditingController controller = new TextEditingController();

  String produk;
  String _produk;
  List<Map<String, dynamic>> _produkList = [];
  List produkList;

  String productUrl = 'produk';
  List productList;
  String namaProduct;

  setState(val) {
    return produk = val;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 8, left: 8),
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(style: BorderStyle.solid)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            FutureBuilder(
                                future: _getProduct(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Container(
                                      child: DropdownButtonHideUnderline(
                                        child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: DropdownButton<String>(
                                            value: produk,
                                            iconSize: 30,
                                            icon: (null),
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16,
                                            ),
                                            hint: Text('Pilih Produk'),
                                            onChanged: (String newValue) {
                                              // setState(() {
                                              //   // produk = newValue;
                                              //   // _onUpdate(num, newValue);
                                              // });
                                              // produk == newValue;
                                              setState(newValue);
                                              print(produk);
                                              controller.text = produk;
                                            },
                                            items: produkList?.map((item) {
                                                  return new DropdownMenuItem(
                                                    child:
                                                        new Text(item['nama']),
                                                    value:
                                                        item['nama'].toString(),
                                                  );
                                                })?.toList() ??
                                                [],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    Container(
                                        width: 0,
                                        height: 0,
                                        child:
                                            Center(child: Text("Connecting")));
                                  }
                                }),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  Future<String> _getProduct() async {
    await Network().getData(productUrl).then((response) {
      var res = json.decode(response.body);
      produkList = res['data'];
    });
  }
}

// class MyNotifier with ChangeNotifer {
//   MyNotifier() {
//     // TODO: do an http request

//     _getProduct();
//   }
// }

// class ProductForm extends StatefulWidget {
//   const ProductForm({Key key}) : super(key: key);

//   @override
//   State<ProductForm> createState() => _ProductFormState();
// }

// TextEditingController controller = new TextEditingController();

// String produk;
// String _produk;
// List<Map<String, dynamic>> _produkList = [];
// List produkList;

// String productUrl = 'produk';
// List productList;
// String namaProduct;

// class _ProductFormState extends State<ProductForm> {
//   @override
//   void initState() {
//     super.initState();

//     _getProduct();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Flexible(
//               child: Padding(
//                   padding:
//                       EdgeInsets.only(top: 10, bottom: 10, right: 8, left: 8),
//                   child: Container(
//                     padding: EdgeInsets.only(left: 15, right: 15, top: 5),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(style: BorderStyle.solid)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         DropDownField(
//                           controller: controller,
//                           itemsVisibleInDropdown: produkList.length,
//                           hintText: "Pilih Produk",
//                           enabled: true,
//                           items: produkList?.map((item) {
//                                 return new DropdownMenuItem(
//                                   child: new Text(item['nama']),
//                                   value: item['nama'].toString(),
//                                 );
//                               })?.toList() ??
//                               [],
//                           onValueChanged: (value) {
//                             produk = value;
//                           },
//                         )
//                       ],
//                     ),
//                   )),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Future<String> _getProduct() async {
//     await Network().getData(productUrl).then((response) {
//       var res = json.decode(response.body);

//       setState(() {
//         produkList = res['data'];
//       });
//     });
//   }
// }

// DropdownButtonHideUnderline(
//   child: ButtonTheme(
//     alignedDropdown: true,
//     child: DropdownButton<String>(
//       value: produk,
//       iconSize: 30,
//       icon: (null),
//       style: TextStyle(
//         color: Colors.black54,
//         fontSize: 16,
//       ),
//       hint: Text('Pilih Produk'),
//       onChanged: (String newValue) {
//         setState(() {
//           produk = newValue;
//           print(produk);
//           controller = produk;
//           // _onUpdate(num, newValue);
//         });
//       },
//       items: produkList?.map((item) {
//             return new DropdownMenuItem(
//               child: new Text(item['nama']),
//               value: item['nama'].toString(),
//             );
//           })?.toList() ??
//           [],
//     ),
//   ),
// ),