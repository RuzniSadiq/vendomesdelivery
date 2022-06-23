import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/usermodel.dart';
import '../screens/driver/driverrequests.dart';


class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  _RoutePageState();

  @override
  Widget build(BuildContext context) {
    return contro();
  }
}

class contro extends StatefulWidget {
  contro();

  @override
  _controState createState() => _controState();
}

class _controState extends State<contro> {
  _controState();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  var role;
  var emaill;
  var id;
  var driveroccupied;
  var operationalcenterid;

  @override
  void initState() {
    if (user?.uid != null) {
      super.initState();
      FirebaseFirestore.instance
          .collection("users") //.where('uid', isEqualTo: user!.uid)
          .doc(user?.uid)
          .get()
          .then((value) {
        this.loggedInUser = UserModel.fromMap(value.data());
      }).whenComplete(() {
        CircularProgressIndicator();
        if (this.mounted) {
          setState(() {
            emaill = loggedInUser.email.toString();
            role = loggedInUser.role.toString();
            id = loggedInUser.uid.toString();
          });
        }
      });
    }
  }

  routing() {
    return
    (role == "driver")
        ? DriverRequests(
      loggedInUser.uid.toString(),
    )
        :Scaffold(
        backgroundColor: Color(0xFF000000),
                body: Center(
                child: CircularProgressIndicator(),
              ));
  }

  @override
  Widget build(BuildContext context) {
    CircularProgressIndicator();
    return routing();
  }
}
