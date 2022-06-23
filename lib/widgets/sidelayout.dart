import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideLayout extends StatelessWidget {
  //const SideLayout({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width /4,
      child: Container(

        decoration: BoxDecoration(
          border:  Border(
            right: BorderSide(width:2.0, color: Color(0xFFBA780F)),
          ),
        ),


        child: Column(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.width / 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Image.asset('assets/images/logo.jpeg'
                  ,
                    width: 280.0,
                  ),
                ),
              ),
            ),
            // Text(
            //   'Build beautiful Apps',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 30,
            //     fontWeight: FontWeight.w400,
            //
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}