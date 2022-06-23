import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart' as u;

import '../helper/responsive_helper.dart';

class VendomeHeaderCustomer extends StatefulWidget {
  //const VendomeHeaderCustomer({Key? key}) : super(key: key);

  GlobalKey<ScaffoldState> drawer;

  String? cusname;
  String? cusaddress;
  String? role;


  VendomeHeaderCustomer({required this.drawer, required this.cusname, required this.cusaddress, required this.role});

  @override
  _VendomeHeaderCustomerState createState() => _VendomeHeaderCustomerState();
}

class _VendomeHeaderCustomerState extends State<VendomeHeaderCustomer> {






  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: buildContainerHeaderContent("mobile", 65, 200, 20, 10, 13),
      tab: buildContainerHeaderContent("tab", 80, 350, 30, 20, 14),
      desktop: buildContainerHeaderContent("desktop",100, 470, 40, 30, 15),
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
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/headerimages/vendomesheader.png",
                  // height: 100,
                  width: worldsgatewidth,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        widget.drawer.currentState!.openDrawer();
                      },
                      child: Image.asset(
                        "assets/images/headerimages/bar.png",
                        width: 25,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/headerimages/location.png",
                            width: 15,
                          ),
                          Text(
                            "  ${widget.cusaddress}",
                            style: TextStyle(color: Colors.white, fontSize: fontsize),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}
