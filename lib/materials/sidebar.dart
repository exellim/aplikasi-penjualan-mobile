import 'package:flutter/material.dart';
import 'package:salessystem/models/profilemodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salessystem/pages/home.dart';

class SideBar extends StatefulWidget {
  // Menu to page
  final Function(int) onMenuTap;
  SideBar({
    Key? key,
    required this.onMenuTap,
  }) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  // Sidebar menu list Start

  // index start
  int initialIndex = 0;

  // Style active and inactive
  final activeTextStyle = TextStyle(color: Colors.white);

  final activeDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.teal);

  final List<String> menuSidebar = [
    "Home",
    "Review Plan",
    "Take Order",
    "Tagihan",
    "Complaint",
    "Sales Visit",
    "Absen",
  ];

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.event_note,
    Icons.post_add_rounded,
    Icons.paid,
    Icons.chat_rounded,
    Icons.business_center_rounded,
    Icons.fingerprint_rounded
  ];
  // Sidebar Menu List End

  // Text Style Start
  TextStyle list = GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 13,
      color: Colors.black54);
  TextStyle font = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontStyle: FontStyle.normal);
  TextStyle fontSemi = GoogleFonts.poppins(
      fontWeight: FontWeight.w600, fontStyle: FontStyle.normal);
  TextStyle fontBold = GoogleFonts.poppins(
      fontWeight: FontWeight.w700, fontStyle: FontStyle.normal);
  // Text Style end

// Data caller start
  UserModel? profile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    UserModel.connectToApi('profile').then((value) {
      profile = value;
      setState(() {});
    });
  }
  // Data Caller end

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, right: 10, left: 8),
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (profile != null)
            Container(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              decoration: BoxDecoration(
                  color: Colors.teal.shade200,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(profile!.img_url.toString(),
                          height: 100, width: 100)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(
                            profile!.name.toString(),
                            style: fontSemi,
                            textScaleFactor: 2,
                          )),
                      Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Text(
                            profile!.emp_number.toString(),
                            style: font,
                            textScaleFactor: 1.5,
                          )),
                    ],
                  )
                ],
              ),
            )
          else
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset("assets/images/cp_logo.png",
                      height: 100, width: 100),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          "Name",
                          style: fontSemi,
                          textScaleFactor: 2,
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text(
                          "Emp_number",
                          style: font,
                          textScaleFactor: 1.5,
                        )),
                  ],
                )
              ],
            ),
          Divider(color: Colors.grey, thickness: 0.5),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Menu"),
          ),

          //  Menu List
          Column(
            children: List.generate(
              menuSidebar.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 1.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate,
                    decoration: initialIndex == index
                        ? activeDecoration
                        : BoxDecoration(),
                    child: ListTile(
                      onTap: () {
                        // print("$index " + menuSidebar[index]);
                        setState(() {
                          initialIndex = index;
                        });
                        widget.onMenuTap(index);
                      },
                      title: Text(
                        menuSidebar[index],
                        style: initialIndex == index ? activeTextStyle : list,
                      ),
                      leading: Icon(
                        icons[index],
                        color: initialIndex == index
                            ? Colors.white
                            : Colors.black54,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Divider(color: Colors.grey, thickness: 0.5),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Other"),
          ),

          ListTile(
            title: Text("Review Take order"),
            leading: Icon(Icons.reviews),
          ),
          ListTile(
            title: Text("Log Out"),
            leading: Icon(Icons.logout_rounded),
            textColor: Colors.red,
            iconColor: Colors.red,
          ),
        ]),
      ),
    );
  }
}
