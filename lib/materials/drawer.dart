import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salessystem/models/profilemodel.dart';
import 'package:salessystem/pages/customer/customer.dart';
import 'package:salessystem/pages/home.dart';
import 'package:salessystem/pages/plan/planlist.dart';
import 'package:salessystem/pages/takeorder/takeorder.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  // const NavigationDrawerWidget({Key? key}) : super(key: key);
  final padding = EdgeInsets.symmetric(horizontal: 5);

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.teal.shade200,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            if (profile != null)
              buildHeader(
                name: profile!.name.toString(),
                empNumber: profile!.emp_number.toString(),
                imgurl: profile!.img_url.toString(),
              )
            else
              InkWell(
                onTap: () {},
                child: Container(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("assets/images/cp_logo.png",
                            height: 80, width: 80),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Fetching name"),
                            const SizedBox(height: 4),
                            Text("fetching empNumber"),
                          ])
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
            ),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              padding: padding,
              children: <Widget>[
                const SizedBox(
                  height: 0,
                ),
                buildMenuItem(
                  text: 'Home',
                  icon: Icons.home_rounded,
                  onClick: () => selectedItem(context, 0),
                ),
                const SizedBox(
                  height: 12,
                ),
                buildMenuItem(
                  text: 'Review Plan',
                  icon: Icons.event_note,
                  onClick: () => selectedItem(context, 1),
                ),
                const SizedBox(
                  height: 12,
                ),
                buildMenuItem(
                  text: 'Take Order',
                  icon: Icons.post_add_rounded,
                  onClick: () => selectedItem(context, 2),
                ),
                const SizedBox(
                  height: 12,
                ),
                buildMenuItem(
                  text: 'Tagihan',
                  icon: Icons.paid,
                ),
                const SizedBox(
                  height: 12,
                ),
                buildMenuItem(
                  text: 'Complaint',
                  icon: Icons.chat_rounded,
                ),
                const SizedBox(
                  height: 12,
                ),
                buildMenuItem(
                  text: 'Sales Visit',
                  icon: Icons.business_center_rounded,
                ),
                Divider(
                  color: Colors.white,
                  thickness: 1.5,
                ),
                const SizedBox(
                  height: 12,
                ),
                buildMenuItem(
                  text: 'Absen',
                  icon: Icons.fingerprint_rounded,
                ),
                buildMenuItem(
                  text: 'Customer',
                  icon: Icons.people_alt,
                  onClick: () => selectedItem(context, 8),
                ),
                buildMenuItem(
                  text: 'Review Take Order',
                  icon: Icons.note_alt_rounded,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String name,
    required String empNumber,
    required String imgurl,
  }) =>
      InkWell(
        onTap: () {},
        child: Container(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(imgurl, height: 80, width: 80),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(name, style: fontSemi, textScaleFactor: 1.5),
                const SizedBox(height: 2),
                Text(empNumber, style: font, textScaleFactor: 1),
              ])
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClick,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClick,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PlanList()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Order()));
        break;
      case 8:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CustomerList()));
        break;
    }
  }
}
