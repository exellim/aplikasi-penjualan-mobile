import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salessystem/models/planmodel.dart';
import 'package:salessystem/models/profilemodel.dart';
import 'package:salessystem/network/api.dart';

class CreatePlan extends StatefulWidget {
  CreatePlan({Key? key}) : super(key: key);

  @override
  State<CreatePlan> createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {
  final formKey = GlobalKey<FormState>(); //key for form

  PostPlan? plan;

  final String url = 'customer';

  // Value list
  var _CustJson = [];
  String? _valCustomer;
  bool checkBoxKunjungan = false;
  bool checkBoxPenagihan = false;
  String? nama,
      kunjungan,
      penagihan,
      jam_mulai,
      jam_selesai,
      empNumber,
      tanggalKunjungan,
      catatan;

  String _catatan = 'Tidak ada Catatan';

  void fetchCustomer() async {
    try {
      final response = await Network().getData(url);
      final jsonData = jsonDecode(response.body) as List;

      setState(() {
        _CustJson = jsonData;
      });
    } catch (e) {}
  }

  UserModel? profile;

  void _getEmp() async {
    UserModel.connectToApi('profile').then((value) {
      profile = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCustomer();
    _getEmp();

    jam_mulai = TimeOfDay.now().toString();
    jam_selesai = TimeOfDay.now().toString();
    print(jam_mulai);
    print(jam_selesai);
    tanggalKunjungan = DateFormat('yyyy-MM-dd').format(date);
    kunjungan = 'Tidak';
    penagihan = 'Tidak';
    catatan = _catatan;

    UserModel.connectToApi('profile').then((value) {
      profile = value;
      setState(() {
        empNumber = profile!.emp_number.toString();
      });
    });
    print(empNumber);
    print(tanggalKunjungan);
    print(kunjungan);
    print(penagihan);
    print(catatan);
    // print(empNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buat Rencana")),
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              Center(
                child: Text("Buat Rencana",
                    textScaleFactor: 2.0,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Card(
                elevation: 4,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                  hint: Text("Pilih Customer"),
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
                                      nama = _valCustomer.toString();
                                      print(nama);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
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
                                onChanged: (bool? value) {
                                  setState(() {
                                    checkBoxKunjungan = value!;
                                    if (checkBoxKunjungan == true) {
                                      kunjungan = "Ya";
                                    } else {
                                      kunjungan = "Tidak";
                                    }
                                  });
                                  print(kunjungan);
                                },
                              ),
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
                                onChanged: (bool? value) {
                                  setState(() {
                                    checkBoxPenagihan = value!;
                                    if (checkBoxPenagihan == true) {
                                      penagihan = "Ya";
                                    } else {
                                      penagihan = "Tidak";
                                    }
                                  });
                                  print(penagihan);
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2005),
                              lastDate: DateTime(2305));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 8.0,
                                  right: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                    left: 8.0,
                                    right: 8.0),
                                child: InkWell(
                                  onTap: () => _selectDate(context),
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      controller: _datecontroller,
                                      decoration: InputDecoration(
                                        focusColor: Colors.teal,
                                        hintText: ('${myFormat.format(date)}'),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide:
                                                BorderSide(color: Colors.grey)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 10.0, left: 8.0, right: 8.0),
                            child: InkWell(
                              onTap: () => selectTimeMulai(context),
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
                                            "${timeMulai.hour}:${timeMulai.minute}",
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
                                top: 10.0, bottom: 10.0, left: 8.0, right: 8.0),
                            child: InkWell(
                              onTap: () => selectTimeSelesai(context),
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
                                            "${timeSelesai.hour}:${timeSelesai.minute}",
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
                              onChanged: (String value) {
                                if (value != null) {
                                  setState(() {
                                    _catatan = value;
                                    catatan = _catatan;
                                  });
                                }
                              },
                              decoration: new InputDecoration(
                                hintText: 'Masukkan Catatan',
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 0.0),
                                ),
                                border: const OutlineInputBorder(),
                                labelStyle: new TextStyle(color: Colors.green),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                          print("Mulai: " + jam_mulai.toString());
                          print("Selesai: " + jam_selesai.toString());
                          print("Tanggal: " + tanggalKunjungan.toString());
                          print("Kunjungan: " + kunjungan.toString());
                          print("penagihan: " + penagihan.toString());
                          print("Emp.Number: " + empNumber.toString());
                          print(catatan);
                          if (formKey.currentState!.validate()) {
                            // emp_number = getEmpNumber().toString();
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
                                  debugPrint(
                                      'Dialog Dissmiss from callback $type');
                                })
                              ..show();
                            PostPlan.sendData(
                                    nama.toString(),
                                    tanggalKunjungan.toString(),
                                    jam_mulai.toString(),
                                    jam_selesai.toString(),
                                    kunjungan.toString(),
                                    penagihan.toString(),
                                    catatan.toString(),
                                    empNumber.toString())
                                .then((value) {
                              plan = value;
                              setState(() {});
                            });
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
                          Navigator().initialRoute;
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
            ]),
          ),
        ),
      ),
    );
  }

  // Date Picker
  TextEditingController _datecontroller = new TextEditingController();
  var myFormat = DateFormat('d-MM-yyyy');
  DateTime date = DateTime.now();
  String? formattedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2001, 8),
        lastDate: DateTime(2101));
    setState(() {
      date = picked ?? date;
      formattedDate = DateFormat('yyyy-MM-dd').format(date);
      tanggalKunjungan = formattedDate.toString();
      print(tanggalKunjungan);
    });
  }

  // Time Picker
  TimeOfDay timeMulai = TimeOfDay.now();
  TimeOfDay? pickedMulai;
  TimeOfDay timeSelesai = TimeOfDay.now();
  TimeOfDay? pickedSelesai;

  Future<Null> selectTimeMulai(BuildContext context) async {
    pickedMulai = await showTimePicker(
      context: context,
      initialTime: timeMulai,
    );

    if (pickedMulai != null) {
      setState(() {
        timeMulai = pickedMulai!;
        jam_mulai = "${timeMulai.hour}:${timeMulai.minute}";
      });
    }
  }

  Future<Null> selectTimeSelesai(BuildContext context) async {
    pickedSelesai = await showTimePicker(
      context: context,
      initialTime: timeSelesai,
    );

    if (pickedSelesai != null) {
      setState(() {
        timeSelesai = pickedSelesai!;
        jam_selesai = "${timeSelesai.hour}:${timeSelesai.minute}";
      });
    }
  }
}
