import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../widgets/header.dart';
import '../../helper/responsive_helper.dart';
import '../../widgets/drivernavigationdrawer.dart';
import 'drivermaptracking.dart';

class DriverRequests extends StatefulWidget {
  String? uid;

  DriverRequests(this.uid);

  @override
  State<DriverRequests> createState() => _DriverRequestsState();
}

class _DriverRequestsState extends State<DriverRequests> {
  var _scaffoldState = new GlobalKey<ScaffoldState>();

  bool _isLoading = true;

  String? cusname;
  String? role;
  String? ongoingorder;
  bool? driveroccuped;
  var entryList;
  var orderid;

  getname() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get()
        .then((myDocuments) {
          setState(() {

            cusname = myDocuments.data()!['name'].toString();
            role = myDocuments.data()!['role'].toString();
            ongoingorder = myDocuments.data()!['ongoingorder'].toString();
          });
    });
  }

  @override
  void initState() {
    super.initState();
    getname();
    _requestPermission();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        drawer: new DriverNavigationDrawer(widget.uid),
        backgroundColor: const Color(0xFF000000),
        body: (_isLoading == true)
            ? const Center(child: const CircularProgressIndicator())
            : Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: ResponsiveWidget(
                      mobile: DriverRequestsContainer(context, "mobile", 70),
                      tab: DriverRequestsContainer(context, "tab", 125),
                      desktop: DriverRequestsContainer(context, "desktop", 125),
                    ),
                  ),
                  Positioned(
                      left: 0.0,
                      top: 0.0,
                      right: 0.0,
                      child: Container(
                          child: VendomeHeader(
                        drawer: _scaffoldState,
                        cusname: cusname,
                        cusaddress: "",
                        role: role,
                      ))),
                ],
              ),
      ),
    );
  }

  Container DriverRequestsContainer(
      BuildContext context, String device, double headergap) {
    return Container(
      width: double.infinity,

      child: Column(

        children: [
          SizedBox(height: headergap,),
          (ongoingorder!="")
          ?Align(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(onPressed: (){


              FirebaseFirestore.instance
                  .collection('delivery')
                  .doc("9WRNvPkoftSw4o2rHGUI")
                  .collection('orders')
                  .doc(ongoingorder)
                  .get()
                  .then((myDocuments) {


                var y = myDocuments.data()!['outletlat'] ==
                    null
                    ? 0.0
                    : myDocuments.data()!['outletlat']
                    .toDouble();
                var cusy = myDocuments.data()!['customerlat'] ==
                    null
                    ? 0.0
                    : myDocuments.data()!['customerlat']
                    .toDouble();
                var z = myDocuments.data()!['outletlong'] ==
                    null
                    ? 0.0
                    : myDocuments.data()!['outletlong']
                    .toDouble();
                var cusz = myDocuments.data()!['customerlong'] ==
                    null
                    ? 0.0
                    : myDocuments.data()!['customerlong']
                    .toDouble();

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DriverMapTracking(
                      myDocuments.data()!['orderid'],
                      LatLng(y, z),
                      LatLng(cusy, cusz),
                      widget.uid!,
                      myDocuments.data()!['customerid'],
                      myDocuments.data()!['orderpickedup'],myDocuments.data()!['orderdelivered'],
                    )));
              });



            },
              color: Color(0xFFBA780F),
              child: const Text("Ongoing", style: TextStyle(
                color: Colors.black
              ),), ),
          )
          :(ongoingorder=="")
              ?
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('delivery')
                  .doc("9WRNvPkoftSw4o2rHGUI")
                  .collection('orders')
                  .where('orderaccepted', isEqualTo: true)
                  .where('ordercancelled', isEqualTo: false)
                  .where('driveraccepted', isEqualTo: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: const Color(0xFFBA780F)),
                    child: DataTable(
                        dividerThickness: 3.0,

                        dataRowHeight: 100,
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Order Information',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label:  Text(
                              'Customer Information',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label:  Text(
                              'Restaurant Information',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label:  Text(
                              'Customer Paid Amount',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label:  Text(
                              'Status',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label:  Text(
                              'Action',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                        rows: _createRows(snapshot.data!)
                    ),
                  ),
                );
              }
          )
          :
          const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }




  List<DataRow> _createRows(QuerySnapshot snapshot) {

    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      return DataRow(cells: [

        DataCell(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ID: ${documentSnapshot.get("orderid").toString()}"),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Wrap(children: newbuilder(documentSnapshot.get("orderdetails"))),
              ),
            ],
          ),
        )),

        DataCell(StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: documentSnapshot.get("customerid").toString()
            ).snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) return Text('Error = ${snapshot.error}');
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!.docs[0]["name"],),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(snapshot.data!.docs[0]["email"],),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(snapshot.data!.docs[0]["contactnumber"],),
                      ),
                    ],
                  ),
                );

              }
              return const Center(child: const CircularProgressIndicator());

            }
        )),
        DataCell(StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('delivery').doc("9WRNvPkoftSw4o2rHGUI").collection('restaurants').where('restaurantid', isEqualTo: documentSnapshot.get("outletid").toString()
            ).snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) return Text('Error = ${snapshot.error}');
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!.docs[0]["name"],),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(snapshot.data!.docs[0]["city"],),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(snapshot.data!.docs[0]["address"],),
                      ),
                    ],
                  ),
                );

              }
              return const Center(child: const CircularProgressIndicator());

            }
        )),
        DataCell(Text("${documentSnapshot.get("totalamount").toString()} AED"),),
        DataCell(Text(
            documentSnapshot.get("orderprepared") == true ? "Order Pending Delivery" : documentSnapshot.get("orderprepared") == false ? "Preparing Order" : "Loading"

        )),
        DataCell(Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: MaterialButton(child:
            const Text(
              "Confirm",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
              color: const Color(0xFF00ff00),
              onPressed: (){





                FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.uid)
                //update method
                    .update({
                  //add the user id inside the favourites array
                  "ongoingorder": documentSnapshot.get("orderid").toString(),
                  "driveroccupied": true,


                });


                // var cusid = snapshot.data!
                //     .docs[index]['userid']
                //     .toString();
                FirebaseFirestore.instance
                    .collection('delivery')
                    .doc("9WRNvPkoftSw4o2rHGUI")
                    .collection('orders')
                    .doc(documentSnapshot.get("orderid"))
                //update method
                    .update({
                  "driverid": widget.uid,
                  //add the user id inside the favourites array
                  "driveraccepted": true
                });

                var y = documentSnapshot.get('outletlat') ==
                    null
                    ? 0.0
                    : documentSnapshot.get('outletlat')
                    .toDouble();
                var cusy = documentSnapshot.get('customerlat') ==
                    null
                    ? 0.0
                    : documentSnapshot.get('customerlat')
                    .toDouble();
                var z = documentSnapshot.get('outletlong') ==
                    null
                    ? 0.0
                    : documentSnapshot.get('outletlong')
                    .toDouble();
                var cusz = documentSnapshot.get('customerlong') ==
                    null
                    ? 0.0
                    : documentSnapshot.get('customerlong')
                    .toDouble();

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DriverMapTracking(
                        documentSnapshot.get('orderid'),
                        LatLng(y, z),
                        LatLng(cusy, cusz),
                        widget.uid!,
                        documentSnapshot.get('customerid'),
                        documentSnapshot.get('orderpickedup'),documentSnapshot.get('orderdelivered'),
                    )));

              },
            ),
          ),
        )),

      ]);
    }).toList();

    return newList;
  }

  List<Widget> newbuilder(List<dynamic> x) {
    List<Widget> m = [];

    entryList = x;

    m.add(const Text("Item: "));

    for (int i = 0; i < entryList.length; i++) {
      //print(entryList.length);

      m.add(Text(
        "(${entryList[i]["quantity"]}) ${entryList[i]["name"]}, ",
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ));
    }

    return m;
  }

  List<Widget> newbuildder(String customerid) {
    List<Widget> m = [];

    m.add(Container(
      height: 200.0,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: customerid
        ).snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: docs.length,
              itemBuilder: (_, i) {
                final data = docs[i].data();
                return Text(data['name'], style: const TextStyle(color: Colors.blue),);
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    ));
    return m;


  }
}
