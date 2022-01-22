import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salessystem/models/customermodel.dart';
import 'package:salessystem/models/planmodel.dart';
import 'package:salessystem/network/api.dart';
import 'package:salessystem/pages/plan/planlist.dart';

class CreatePlan extends StatefulWidget {
  CreatePlan({Key key}) : super(key: key);

  @override
  _CreatePlanState createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
  final formKey = GlobalKey<FormState>(); //key for form

  String nama,
      jamMulai,
      jamSelesai,
      catatan,
      tujuan,
      kunjungan_value,
      penagihan_value;

  TimeOfDay _jamMulai;
  TimeOfDay _jamSelesai;

    TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);


  bool checkBoxKunjungan = false;
  bool checkBoxPenagihan = false;
  String kunjungan;
  String penagihan;

  TextEditingController _datecontroller = new TextEditingController();
  DateTime date = DateTime.now();

  var myFormat = DateFormat('d-MM-yyyy');

  Future getCustomer() async {
    var response = Network().getData('customer');
    var body = jsonDecode(response.body);
    return body;
  }

  @override
  Widget build(BuildContext context) {
    PostCustomer postResult = null;
    TextEditingController TECnama = new TextEditingController();
    return Scaffold(
        appBar: AppBar(title: Text("Create Plan")),
        resizeToAvoidBottomInset: true,
        body: Form(
            key: formKey,
            child: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                      child: Text("Create Plan",
                          textScaleFactor: 2.0,
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  // checkbox
                  Card(
                    elevation: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Kunjungan",
                                textAlign: TextAlign.center,
                              ),
                              Checkbox(
                                  value: checkBoxKunjungan,
                                  onChanged: (bool value) {
                                    valKunjungan(value); // print(value);
                                  }),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Penagihan",
                                textAlign: TextAlign.center,
                              ),
                              Checkbox(
                                value: checkBoxPenagihan,
                                onChanged: (bool value) {
                                  valPenagihan(value);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // Date Picker
                  Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Tanggal Kedatangan: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 8.0, right: 8.0),
                          child: InkWell(
                            onTap: () => _selectDate(context),
                            child: IgnorePointer(
                              child: TextFormField(
                                controller: _datecontroller,
                                decoration: InputDecoration(
                                  focusColor: Colors.teal,
                                  hintText: ('${myFormat.format(date)}'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 8.0,
                                  right: 8.0),
                              child: InkWell(
                                onTap: () => _mulai(context),
                                child: IgnorePointer(
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Jam Mulai',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.watch_later_outlined,
                                                color: Colors.white),
                                            Text(
                                              jamMulai,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 8.0,
                                  right: 8.0),
                              child: InkWell(
                                onTap: () => _selectTime(),
                                child: IgnorePointer(
                                  child: Container(
                                    padding: EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Jam Selesai',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.watch_later_outlined,
                                                color: Colors.white),
                                            Text(
                                              "${_jamSelesai.hour}:${_jamSelesai.minute}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        // Catatan
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 200,
                            child: SizedBox(
                              height: 100,
                              child: new TextFormField(
                                maxLines: 8,
                                // expands: true,
                                decoration: new InputDecoration(
                                  hintText: 'Masukkan Catatan',
                                  enabledBorder: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 0.0),
                                  ),
                                  border: const OutlineInputBorder(),
                                  labelStyle:
                                      new TextStyle(color: Colors.green),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            color: Colors.green,
                            padding: EdgeInsets.all(20),
                            onPressed: () {
                              print(kunjungan_value);
                              print(penagihan_value);
                              print(jamMulai.toString());
                              print(jamSelesai.toString());
                              if (formKey.currentState.validate()) {
                                // AwesomeDialog(
                                //     context: context,
                                //     animType: AnimType.LEFTSLIDE,
                                //     headerAnimationLoop: false,
                                //     dialogType: DialogType.SUCCES,
                                //     showCloseIcon: true,
                                //     title: 'Succes',
                                //     desc: 'Plan telah ditambahkan!',
                                //     btnOkOnPress: () => Navigator.of(context)
                                //         .push(MaterialPageRoute(
                                //             builder: (context) => PlanList())),
                                //     btnOkIcon: Icons.check_circle,
                                //     onDissmissCallback: (type) {
                                //       debugPrint(
                                //           'Dialog Dissmiss from callback $type');
                                //     })
                                //   ..show();
                                // PostPlan.connectApi(
                                //         nama,
                                //         jamMulai,
                                //         jamSelesai,
                                //         catatan,
                                //         kunjungan_value,
                                //         penagihan_value)
                                //     .then((value) {
                                //   setState(() {});
                                // }
                                // );
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Tambahkan",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                        // Spacer(),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cancel,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Batal",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2001, 8),
        lastDate: DateTime(2101));
    setState(() {
      date = picked ?? date;
      print(date);
    });
  }

  Future<void> _mulai(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: _jamMulai,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != _jamMulai) {
      setState(() {
        jamMulai = _jamMulai.toString();
        jamMulai = "${_jamMulai.hour}:${_jamMulai.minute}";
        print(jamMulai);
      });
    } else {
      setState(() {
        jamMulai = _jamMulai.toString();
        print(jamMulai);
      });
    }
  }

void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  Widget valKunjungan(value) {
    setState(() {
      checkBoxKunjungan = value;
    });
    if (value == true) {
      kunjungan = 'ya';
      kunjungan_value = kunjungan;
      print(kunjungan_value);
    } else {
      kunjungan = 'tidak';
      kunjungan_value = kunjungan;
      print(kunjungan_value);
    }
  }

  Widget valPenagihan(value) {
    setState(() {
      checkBoxPenagihan = value;
    });
    if (value == true) {
      penagihan = 'ya';
      penagihan_value = penagihan;
      print(penagihan_value);
    } else {
      penagihan = 'tidak';
      penagihan_value = penagihan;
      print(penagihan_value);
    }
  }
}
