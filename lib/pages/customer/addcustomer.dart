import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                            onPressed: () {},
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
