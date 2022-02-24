import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csvmethodchannel/main_views/home_with_bottom_navbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'main.dart';
import 'main_views/home_screen.dart';
import 'package:permission_handler/permission_handler.dart'as permissionHandler;
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool checkpermission = false;
  String errorMessage = '';
  bool _obscureText = true;
   late String email, password;
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



    }
  }

  int _locationPermissionCount = 0;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        centerTitle: true,
        title: new Text(
          'Login',
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 25,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          'Email address',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    email = value; // get value from TextField
                  },
                  decoration: InputDecoration(border: UnderlineInputBorder()),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  obscureText: _obscureText,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    password = value; //get value from textField
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        color: Colors.grey,
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      border: UnderlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Material(
                  elevation: 1,
                  color: Colors.green[5],
                  borderRadius: BorderRadius.circular(32.0),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        try {
                          await _auth
                              .signInWithEmailAndPassword(
                                  email: email, password: password)
                              .then((uid) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeWithBottomNavBar()),
                                  ));
                        } on FirebaseAuthException {
                          errorMessage =
                              'Email and/or password is invalid or does not exist';
                        }
                        setState(() {});
                      }
                    },
                    minWidth: 200.0,
                    height: 45.0,
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Register now",
                    style: TextStyle(
                        color: Colors.grey[700], fontWeight: FontWeight.w900),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
