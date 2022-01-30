import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salessystem/models/notamodel.dart';
import 'package:salessystem/network/api.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class NotaFaktur extends StatefulWidget {
  NotaFaktur({Key? key}) : super(key: key);

  @override
  State<NotaFaktur> createState() => _NotaFakturState();
}

class _NotaFakturState extends State<NotaFaktur> {
  GlobalKey<FormState> globalKey = new GlobalKey<FormState>();
  NotaModel notaModel = new NotaModel();

  final oCcy = new NumberFormat("#,##0.00", "en_US");
  final formatCurrency = new NumberFormat.simpleCurrency();

  var textgt;

// Customer List start
  TextEditingController phoneTEC = new TextEditingController();
  String? phone;
  var _CustJson = [];
  String? _valCustomer;
  void fetchCustomer() async {
    try {
      final response = await Network().getData('customer');
      final jsonData = jsonDecode(response.body) as List;

      setState(() {
        _CustJson = jsonData;
      });
    } catch (e) {}
  }
  // Customer List End

  @override
  void initState() {
    super.initState();
    fetchCustomer();
    notaModel.produk = new List<String>.empty(growable: true);
    notaModel.jumlah = new List<int>.empty(growable: true);
    notaModel.harga = new List<int>.empty(growable: true);
    notaModel.subTotal = new List<int>.empty(growable: true);
    notaModel.produk!.add("");
    notaModel.jumlah!.add(-0);
    notaModel.harga!.add(-0);
    notaModel.subTotal!.add(-0);
    // phoneTEC.text = (phone == null) ? '' : phone.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nota Faktur")),
      body: _uiWidget(),
    );
  }

  Widget _uiWidget() {
    return new Form(
      key: globalKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pilih Customer"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                              hint: Text("-----"),
                              value: _valCustomer,
                              items: _CustJson.map((item) {
                                return DropdownMenuItem(
                                  child: Text(item['nama']),
                                  value: item['nama'],
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _valCustomer = value!.toString();
                                  this.notaModel.custName =
                                      _valCustomer.toString();
                                  var handphone = _CustJson.firstWhere(
                                      (element) =>
                                          element['nama'] == value.toString(),
                                      orElse: () {
                                    return null;
                                  });
                                  phone = handphone['handphone'].toString();
                                  phoneTEC.text = phone.toString();
                                  this.notaModel.handphone = phone.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Nomor Telfon"),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 18),
                      Expanded(
                        child: TextField(
                          controller: phoneTEC,
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _produkContainer(),
              Center(
                child: FormHelper.submitButton("Save", () {
                  if (validateAndSave()) {
                    print(notaModel.toJson());
                    notaResult();
                    notaModel.subTotal!.clear();
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _produkContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Produk List"),
          ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    produkUI(index),
                  ],
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: notaModel.produk!.length),
          Text(("Total: ${formatCurrency.format(notaModel.grandTotal)}")),
        ],
      ),
    );
  }

  Widget produkUI(index) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FormHelper.inputFieldWidgetWithLabel(
                    context,
                    Icon(
                      Icons.add_shopping_cart_rounded,
                      size: 20,
                    ),
                    "item$index",
                    "Nama Produk",
                    "", (onValidate) {
                  if (onValidate.isEmpty) {
                    return 'Produk ${index + 1} tidak boleh kosong!';
                  } else
                    return null;
                }, (onSaved) {
                  notaModel.produk![index] = onSaved;
                },
                    initialValue: notaModel.produk![index],
                    borderColor: Colors.black,
                    borderFocusColor: Colors.teal,
                    borderRadius: 15,
                    paddingLeft: 0,
                    paddingRight: 0,
                    showPrefixIcon: false),
              ],
            )),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FormHelper.inputFieldWidgetWithLabel(
                  context,
                  Icon(
                    Icons.add,
                    size: 20,
                  ),
                  "item$index",
                  "qty",
                  "",
                  (onValidate) {
                    if (onValidate.isEmpty) {
                      return 'Produk ${index + 1} tidak boleh kosong!';
                    } else
                      return null;
                  },
                  (onSaved) {
                    notaModel.jumlah![index] = int.parse(onSaved);
                  },
                  initialValue: notaModel.jumlah![index].toString(),
                  borderColor: Colors.black,
                  borderFocusColor: Colors.teal,
                  borderRadius: 15,
                  paddingLeft: 0,
                  paddingRight: 0,
                ),
              ],
            )),
            Flexible(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FormHelper.inputFieldWidgetWithLabel(
                  context,
                  Icon(
                    Icons.monetization_on_rounded,
                    size: 20,
                  ),
                  "harga$index",
                  "Harga",
                  "",
                  (onValidate) {
                    if (onValidate.isEmpty) {
                      return 'Harga ${index + 1} tidak boleh kosong!';
                    } else
                      return null;
                  },
                  (onSaved) {
                    notaModel.harga![index] = int.parse(onSaved);
                  },
                  initialValue: notaModel.harga![index].toString(),
                  borderColor: Colors.black,
                  borderFocusColor: Colors.teal,
                  borderRadius: 15,
                  paddingLeft: 0,
                  paddingRight: 0,
                ),
              ],
            )),
          ],
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                child: SizedBox(
                  width: 50,
                  child: IconButton(
                    color: Colors.teal,
                    icon: Icon(Icons.add_circle),
                    onPressed: () {
                      addProductControl();
                    },
                  ),
                ),
                visible: index == notaModel.produk!.length - 1,
              ),
              Visibility(
                child: SizedBox(
                  width: 50,
                  child: IconButton(
                    color: Colors.red,
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      removeProductControl(index);
                    },
                  ),
                ),
                visible: index > 0,
              ),
            ]),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }

  void addProductControl() {
    setState(() {
      notaModel.produk!.add("");
      notaModel.jumlah!.add(0);
      notaModel.harga!.add(0);
      // notaModel.subTotal!.add(0);
    });
  }

  void removeProductControl(index) {
    setState(() {
      if (notaModel.produk!.length > 1) {
        notaModel.produk!.removeAt(index);
        notaModel.jumlah!.removeAt(index);
        notaModel.harga!.removeAt(index);
      }
    });
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void notaResult() {
    var gt = 0;
    for (int i = 0; i < notaModel.jumlah!.length; i++) {
      notaModel.subTotal;
      notaModel.subTotal!.add(notaModel.jumlah![i] * notaModel.harga![i]);
    }
    for (var i = 0; i < notaModel.subTotal!.length; i++) {
      gt += notaModel.subTotal![i];
      // notaModel.subTotal!.clear();
    }
    setState(() {
      notaModel.grandTotal = gt;
      textgt = "Rp ${oCcy.format(gt / 100)}";
    });
    print("Sub Total: " + notaModel.subTotal.toString());
    print("Grand Total: " + gt.toString());
  }
}
