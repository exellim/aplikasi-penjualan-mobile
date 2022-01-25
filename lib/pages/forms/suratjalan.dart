import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salessystem/models/notafaktur.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../network/api.dart';

class SuratJalan extends StatefulWidget {
  SuratJalan({Key key}) : super(key: key);

  @override
  _SuratJalanState createState() => _SuratJalanState();
}

class _SuratJalanState extends State<SuratJalan> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  NotaFakturModel notaFakturModel = NotaFakturModel();

  List namaList;

  String nama;
  String namaIndex;
  String _nama;
  String _namaIndex;

  String tipe_pembayaran;
  String pembayaran = "cash";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getNama();
    notaFakturModel.produk = List<String>.empty(growable: true);
    notaFakturModel.produk.add("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surat Jalan"),
      ),
      body: _uiWidget(),
    );
  }

  Widget _uiWidget() {
    return new Form(
        key: globalKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              // No Nota
              FormHelper.inputFieldWidgetWithLabel(
                  context,
                  Icon(Icons.description_rounded),
                  "nota",
                  "No Nota",
                  "SJ-xxxx", (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'No nota harus di isi';
                }
                return null;
              }, (onSavedVal) {
                this.notaFakturModel.no_nota = onSavedVal;
              },
                  initialValue: notaFakturModel.no_nota ?? "",
                  borderColor: Colors.grey,
                  borderFocusColor: Colors.teal,
                  borderRadius: 8.0,
                  fontSize: 14.0,
                  labelFontSize: 14.0,
                  paddingLeft: 0,
                  paddingRight: 0),

              // Customer name list
              Padding(
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
                        DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              value: _nama,
                              iconSize: 30,
                              icon: (null),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              hint: Text('Pilih Customer'),
                              onChanged: (String newValue) {
                                setState(() {
                                  _nama = newValue;
                                  _getNama();
                                  // print(_nama);
                                  nama = _nama;
                                  print(nama);
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

              //Tipe Pembayaran
              Text("Pilih Pembayaran"),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Column(children: [
                    Text("Cash"),
                    Radio(
                        value: "cash",
                        groupValue: pembayaran,
                        onChanged: (value) {
                          setState(() {
                            pembayaran = value;
                            tipe_pembayaran = pembayaran;
                            print(tipe_pembayaran);
                          });
                        })
                  ])),
                  Expanded(
                      child: Column(children: [
                    Text("Debit"),
                    Radio(
                        value: "debit",
                        groupValue: pembayaran,
                        onChanged: (value) {
                          setState(() {
                            pembayaran = value;
                            tipe_pembayaran = pembayaran;
                            print(tipe_pembayaran);
                          });
                        })
                  ])),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: notaFakturModel.produk.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [produkUI(index)],
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              )
            ]),
          ),
        ));
  }

  Widget produkUI(index) {
    return Row(
      children: [
        Flexible(
          child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, right: 8, left: 8),
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
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
                          value: _namaIndex,
                          iconSize: 30,
                          icon: (null),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          hint: Text('Pilih Customer'),
                          onChanged: (String newValue) {
                            setState(() {
                              _namaIndex = newValue;
                              _getNama();
                              namaIndex = _namaIndex;
                              namaIndex = namaIndex + "${index + 1}";
                              print(namaIndex);
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
        ),
        Visibility(
          child: SizedBox(
              width: 35,
              child: IconButton(
                  onPressed: () {
                    addProdukControl();
                  },
                  icon: Icon(Icons.add_circle, color: Colors.teal))),
          visible: index == notaFakturModel.produk.length - 1,
        ),
        Visibility(
          child: SizedBox(
              width: 35,
              child: IconButton(
                  onPressed: () {
                    removeProdukControl(index);
                  },
                  icon: Icon(Icons.remove_circle, color: Colors.red))),
          visible: index > 0,
        )
      ],
    );
  }

  void addProdukControl() {
    setState(() {
      notaFakturModel.produk.add("");
    });
  }

  void removeProdukControl(index) {
    if (notaFakturModel.produk.length > 1) {
      notaFakturModel.produk.removeAt(index);
    }
  }

  String url = 'customer';
  Future<String> _getNama() async {
    await Network().getData(url).then((response) {
      var data = json.decode(response.body);

      setState(() {
        namaList = data['data'];
      });
    });
  }
}
