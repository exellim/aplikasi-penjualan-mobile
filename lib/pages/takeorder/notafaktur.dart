import 'dart:convert';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salessystem/models/notamodel.dart';
import 'package:salessystem/models/profilemodel.dart';
import 'package:salessystem/network/api.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class NotaFaktur extends StatefulWidget {
  NotaFaktur({Key? key}) : super(key: key);

  @override
  State<NotaFaktur> createState() => _NotaFakturState();
}

class _NotaFakturState extends State<NotaFaktur> {
  GlobalKey<FormState> globalKey = new GlobalKey<FormState>();
  final keySignaturePad = new GlobalKey<SfSignaturePadState>();
  NotaModel notaModel = new NotaModel();
  PostNota? nota;

  final oCcy = new NumberFormat("#,##0.00", "en_US");
  final formatCurrency = new NumberFormat.simpleCurrency();

  var textgt;
  String? empNumber;
  Map<String, String> data = {};

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

  UserModel? profile;

  void _getEmp() async {
    UserModel.connectToApi('profile').then((value) {
      profile = value;
      setState(() {});
    });
  }

  var idNota;

  // Map<dynamic, String> nama_produk = {};
  // Map<dynamic, int> harga_produk = {};
  // Map<dynamic, int> qty_produk = {};
  // Map<dynamic, int> sub_produk = {};

  List<String> nama_produk = [];
  List<int> harga_produk = [];
  List<int> qty_produk = [];
  List<int> sub_produk = [];
  List<int> sub_total = [];

  @override
  void initState() {
    super.initState();
    fetchCustomer();
    _getEmp();
    // postingList();

    notaModel.produk = new List<String>.empty(growable: true);
    notaModel.jumlah = new List<int>.empty(growable: true);
    notaModel.harga = new List<int>.empty(growable: true);
    notaModel.subTotal = new List<int>.empty(growable: true);
    notaModel.produk!.add("");
    notaModel.jumlah!.add(-0);
    notaModel.harga!.add(-0);

    // phoneTEC.text = (phone == null) ? '' : phone.toString();
    UserModel.connectToApi('profile').then((value) {
      profile = value;
      setState(() {
        empNumber = profile!.emp_number.toString();
      });
    });
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
                child: Row(
                  children: [
                    FormHelper.submitButton("Save", () {
                      if (validateAndSave()) {
                        print(notaModel.toJson());
                        notaResult();
                        // notaModel.subTotal!.clear();
                      }
                    }, borderColor: Colors.green, btnColor: Colors.green),
                    SizedBox(
                      width: 4,
                    ),
                    FormHelper.submitButton("Send", () {
                      if (globalKey.currentState!.validate()) {
                        postingList();
                        AwesomeDialog(
                            context: context,
                            animType: AnimType.LEFTSLIDE,
                            headerAnimationLoop: false,
                            dialogType: DialogType.SUCCES,
                            showCloseIcon: true,
                            title: 'Succes',
                            desc: 'Plan telah ditambahkan!',
                            btnOkOnPress: () => Navigator.of(context).pop(),
                            btnOkIcon: Icons.check_circle,
                            onDissmissCallback: (type) {
                              debugPrint('Dialog Dissmiss from callback $type');
                            })
                          ..show();
                      }
                    },
                        borderColor: Colors.green.shade500,
                        btnColor: Colors.green.shade500),
                  ],
                ),
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
          Text(notaModel.grandTotal != null
              ? "Total: ${formatCurrency.format(notaModel.grandTotal)}"
              : "Total: 0"),
        ],
      ),
    );
  }

  Future onPrint() async {
    final image = await keySignaturePad.currentState?.toImage();
    final imageSignature = await image!.toByteData();
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
                  // nama_produk[index] = onSaved;
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
                    // qty_produk[index] = onSaved;
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
                    // harga_produk[index] = onSaved;
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
        notaModel.subTotal!.removeAt(index);
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
    // var notaModelNew = new NotaModel();
    notaModel.subTotal = [];
    for (int i = 0; i < notaModel.jumlah!.length; i++) {
      // subtot = notaModel.subTotal!.add(notaModel.jumlah![i] * notaModel.harga![i]);
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

  postingList() async {
    data = {
      "notaId": "$empNumber",
      "nama": _valCustomer.toString(),
      "nomor_telfon": phone.toString(),
    };
    var nama_produk = "[";
    for (var i = 0; i < notaModel.produk!.length; i++) {
      if (i == (notaModel.produk!.length) - 1) {
        nama_produk += "'" + notaModel.produk![i] + "'";
      } else {
        nama_produk += "'" + notaModel.produk![i] + "',";
      }
    }
    nama_produk += "]";
    data.addAll({'nama_produk': nama_produk});

    var qty_produk = "[";
    for (var y = 0; y < notaModel.jumlah!.length; y++) {
      if (y == (notaModel.jumlah!.length) - 1) {
        qty_produk += notaModel.jumlah![y].toString();
      } else {
        qty_produk += notaModel.jumlah![y].toString() + ",";
      }
    }
    qty_produk += "]";
    data.addAll({'qty_produk': qty_produk});

    var harga_produk = "[";
    for (var x = 0; x < notaModel.harga!.length; x++) {
      if (x == (notaModel.harga!.length) - 1) {
        harga_produk += notaModel.harga![x].toString();
      } else {
        harga_produk += notaModel.harga![x].toString() + ",";
      }
    }
    harga_produk += "]";
    data.addAll({'harga_produk': harga_produk});

    var subtotal_harga = "[";
    for (var n = 0; n < notaModel.subTotal!.length; n++) {
      if (n == (notaModel.subTotal!.length) - 1) {
        subtotal_harga += notaModel.subTotal![n].toString();
      } else {
        subtotal_harga += notaModel.subTotal![n].toString() + ",";
      }
    }
    subtotal_harga += "]";
    data.addAll({'subtotal_harga': subtotal_harga});

    var response = await Network().sendData("nota/add", data);
    // var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      print('success');
    } else {
      print(response.body);

      print('error, data not send');
    }
  }
}
