import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:salessystem/models/customerModel.dart';


CustomerModel _customerModel;
TextEditingController namaController = TextEditingController();
TextEditingController alamatController = TextEditingController();
TextEditingController handphoneController = TextEditingController();

Future createCustomer(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 60,
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.teal,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        Text(
                          "Add Customer",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 25,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(children: [
                      // Nama Customer
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          width: MediaQuery.of(context)
                              .size
                              .width, // do it in both Container
                          child: TextFormField(
                            controller: namaController,
                            decoration: InputDecoration(
                              hintText: "Nama Customer",
                              contentPadding: EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Alamat Rumah
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          width: MediaQuery.of(context)
                              .size
                              .width, // do it in both Container
                          child: TextFormField(
                            controller: alamatController,
                            decoration: InputDecoration(
                              hintText: "Alamat Customer",
                              contentPadding: EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Nomor Handphone
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          width: MediaQuery.of(context)
                              .size
                              .width, // do it in both Container
                          child: TextFormField(
                            controller: handphoneController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: "No. Handphone Customer",
                              contentPadding: EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 25.0, right: 15.0),
                        child: Align(
                          alignment: FractionalOffset.centerRight,
                          child: FlatButton(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            child: new Text('round button'),
                            onPressed: () async {
                              String nama = namaController.text;
                              String alamat_rumah = alamatController.text;
                              String handphone = handphoneController.text;

                              CustomerModel customer = await submitCustomer(
                                  nama, alamat_rumah, handphone);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
              ],
            ),
          ),
        );
      });
}

Future<CustomerModel> submitCustomer(
    String nama, String alamat_rumah, String handphone) async {
  final String url = 'http://127.0.0.1:8000/api/customer/add';
  var response = await http.post(Uri.parse(url), body: {
    "nama": nama,
    "alamat_rumah": alamat_rumah,
    "handphone": handphone,
  });
  var data = response.body;
  print(data);

  if (response.statusCode == 200) {
    String responseString = response.body;
    customerModelFromJson(responseString);
  } else {
    return null;
  }
}
