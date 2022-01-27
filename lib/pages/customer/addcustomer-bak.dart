import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salessystem/models/customermodel.dart';
import 'package:salessystem/pages/customer/customer.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AddCustomerBak extends StatefulWidget {
  AddCustomerBak({Key key}) : super(key: key);

  @override
  _AddCustomerBakState createState() => _AddCustomerBakState();
}

class _AddCustomerBakState extends State<AddCustomerBak> {
  final formKey = GlobalKey<FormState>(); //key for form
  String nama, alamat, handphone;
  PostCustomer postResult = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new customer"),
      ),
      resizeToAvoidBottomInset: true,
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, right: 8.0, left: 8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Nama harus terisi";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Nama',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.teal),
                                borderRadius: BorderRadius.circular(15),
                              )),
                          onChanged: (value) {
                            setState(() {
                              nama = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Alamat harus terisi";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Alamat',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.teal),
                                borderRadius: BorderRadius.circular(15),
                              )),
                          onChanged: (value) {
                            setState(() {
                              alamat = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Nomor Handphone harus terisi";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              labelText: 'No Handphone',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.teal),
                                borderRadius: BorderRadius.circular(15),
                              )),
                          onChanged: (value) {
                            setState(() {
                              handphone = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              color: Colors.green,
                              padding: EdgeInsets.all(20),
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  AwesomeDialog(
                                      context: context,
                                      animType: AnimType.LEFTSLIDE,
                                      headerAnimationLoop: false,
                                      dialogType: DialogType.SUCCES,
                                      showCloseIcon: true,
                                      title: 'Succes',
                                      desc: 'Customer telah ditambahkan!',
                                      btnOkOnPress: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  CustomerList())),
                                      btnOkIcon: Icons.check_circle,
                                      onDissmissCallback: (type) {
                                        debugPrint(
                                            'Dialog Dissmiss from callback $type');
                                      })
                                    ..show();
                                  PostCustomer.connectApi(
                                          nama, alamat, handphone)
                                      .then((value) {
                                    setState(() {});
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    size: 25,
                                    color: Colors.yellow,
                                  ),
                                  Text("Tambahkan")
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
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
                      )
                    ],
                  ),
                ),
              ]),
            ),
          )),
    );
  }
}
