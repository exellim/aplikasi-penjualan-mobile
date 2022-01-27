import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salessystem/models/customermodel.dart';
import 'package:salessystem/models/planmodel.dart';
import 'package:salessystem/network/api.dart';
import 'package:salessystem/pages/plan/planlist.dart';

class CreatePlanBak extends StatefulWidget {
  CreatePlanBak({Key key}) : super(key: key);

  @override
  _CreatePlanBakState createState() => _CreatePlanBakState();
}

class _CreatePlanBakState extends State<CreatePlanBak> {
  final formKey = GlobalKey<FormState>(); //key for form

  String nama,
      tanggalKunjungan,
      jamMulai,
      jamSelesai,
      catatan,
      tujuan,
      kunjungan_value,
      emp_number,
      tujuan_value;

  var now = DateTime.now();

  List namaList;
  String _nama;

  String _catatan;

  TimeOfDay timeMulai;
  TimeOfDay pickedMulai;
  TimeOfDay timeSelesai;
  TimeOfDay pickedSelesai;

  bool checkBoxKunjungan = false;
  bool checkBoxPenagihan = false;
  String kunjungan;
  String penagihan;

  TextEditingController _datecontroller = new TextEditingController();
  String formattedDate;
  DateTime date = DateTime.now();

  var myFormat = DateFormat('d-MM-yyyy');

  @override
  void initState() {
    super.initState();
    timeMulai = TimeOfDay.now();
    timeSelesai = TimeOfDay.now();
    _getNama();
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
                                    child: DropdownButton<String>(
                                      value: _nama,
                                      iconSize: 30,
                                      icon: (null),
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                      hint: Text('Select State'),
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
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
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
                                  top: 10.0,
                                  bottom: 10.0,
                                  left: 8.0,
                                  right: 8.0),
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
                                  setState(() {
                                    _catatan = value;
                                    catatan = _catatan;
                                  });
                                },
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
                              print(tujuan_value);
                              print(jamMulai);
                              print(jamSelesai);
                              print(emp_number);
                              if (formKey.currentState.validate()) {
                                setState(() {
                                  emp_number = getEmpNumber().toString();
                                });
                                AwesomeDialog(
                                    context: context,
                                    animType: AnimType.LEFTSLIDE,
                                    headerAnimationLoop: false,
                                    dialogType: DialogType.SUCCES,
                                    showCloseIcon: true,
                                    title: 'Succes',
                                    desc: 'Plan telah ditambahkan!',
                                    btnOkOnPress: () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => PlanList())),
                                    btnOkIcon: Icons.check_circle,
                                    onDissmissCallback: (type) {
                                      debugPrint(
                                          'Dialog Dissmiss from callback $type');
                                    })
                                  ..show();
                                PostPlan.connectApi(
                                        nama,
                                        tanggalKunjungan,
                                        jamMulai,
                                        jamSelesai,
                                        catatan,
                                        kunjungan_value,
                                        tujuan_value,
                                        emp_number)
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
      formattedDate = DateFormat('yyyy-MM-dd').format(date);
      tanggalKunjungan = formattedDate;
      print(tanggalKunjungan);
    });
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
      tujuan_value = penagihan;
      print(tujuan_value);
    } else {
      penagihan = 'tidak';
      tujuan_value = penagihan;
      print(tujuan_value);
    }
  }

  Future<Null> selectTimeMulai(BuildContext context) async {
    pickedMulai = await showTimePicker(
      context: context,
      initialTime: timeMulai,
    );

    if (pickedMulai != null) {
      setState(() {
        timeMulai = pickedMulai;
        jamMulai = "${timeMulai.hour}:${timeMulai.minute}";
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
        timeSelesai = pickedSelesai;
        jamSelesai = "${timeSelesai.hour}:${timeSelesai.minute}";
      });
    }
  }

  Future getEmpNumber() async {
    var respone = Network().getData('profile');
    var body = jsonDecode(respone.body);

    setState(() {
      emp_number = body['data']['emp_number'];
    });
    return body;
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
