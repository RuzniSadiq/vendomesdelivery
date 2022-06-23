import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/driver/driverrequests.dart';
import '../screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart' as u;

class DriverNavigationDrawer extends StatelessWidget {
  //const DriverNavigationDrawer({Key? key}) : super(key: key);

  String? uid;

  // //constructor
  DriverNavigationDrawer(
    this.uid,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF262626),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            // Text(
            //   "Booking",
            //   style: TextStyle(color: Colors.white),
            // ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                'Dashboard',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => DeoManageHotels(uid),
                // ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                'Requests',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DriverRequests(uid),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text(
                'Past Rides',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => DeoManageCars(uid),
                // ));
              },
            ),
            Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
                logout(context);
              },
            ),
          ],
        ),
      );

  //logout function
  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await u.FirebaseAuth.instance.signOut();
    print("Signed out Successfully");

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
