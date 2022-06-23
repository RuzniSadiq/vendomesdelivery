import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart' as u;

import '../helper/responsive_helper.dart';

class VendomeHeader extends StatefulWidget {
  //const VendomeHeader({Key? key}) : super(key: key);

  GlobalKey<ScaffoldState> drawer;

  String? cusname;
  String? cusaddress;
  String? role;


  VendomeHeader({required this.drawer, required this.cusname, required this.cusaddress, required this.role});

  @override
  _VendomeHeaderState createState() => _VendomeHeaderState();
}

class _VendomeHeaderState extends State<VendomeHeader> {






  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: buildContainerHeaderContent("mobile", 65, 200, 40, 10, 13),
      tab: buildContainerHeaderContent("tab", 90, 350, 60, 20, 14),
      desktop: buildContainerHeaderContent("desktop",110, 470, 80, 30, 15),
    );
  }

  Container buildContainerHeaderContent(String platform, double headerheight, double worldsgatewidth, double logoradius, double avatarradius, double fontsize) {
    return Container(
        height: headerheight,
        decoration: BoxDecoration(
          color: Colors.black,

          // border: Border.all(color: Color(0xFFBA780F)),

          border: Border(
            bottom: BorderSide(width: 2.0, color: Color(0xFFBA780F)),
          ),
        ),
        child:
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image(
                    image: AssetImage(
                      'assets/images/logo.jpeg',
                    ),
                    // backgroundColor: Colors.black,
                    // radius: logoradius,
                    width: logoradius,

                    // backgroundImage: AssetImage(
                    //   'assets/images/logo.jpeg',
                    // ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/headerimages/vendomesheader.png",
                    // height: 100,
                    width: worldsgatewidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: avatarradius,
                      backgroundImage: AssetImage(
                        'assets/images/premiumbrands/premiumbrands1.jpeg',
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        widget.drawer.currentState!.openDrawer();
                      },
                      child: Image.asset(
                        "assets/images/headerimages/bar.png",
                        width: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        widget.cusname.toString(),
                        style: TextStyle(color: Colors.white, fontSize: fontsize),
                      )),
                ),

              ],
            ),
          ],
        ),

    );
  }
}
