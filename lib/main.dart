import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csvmethodchannel/login.dart';
import 'package:csvmethodchannel/main_views/account_method.dart';
import 'package:csvmethodchannel/main_views/home_with_bottom_navbar.dart';
import 'package:csvmethodchannel/registration/get_started.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart' as permissionHandler;
import 'main_views/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// final Future<FirebaseApp> _initialization = Firebase.initializeApp();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //initialRoute: '/home',
      title: 'Cashful',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(1, 67, 55, 1),
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromRGBO(1, 67, 55, 1),
          ),
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: Color.fromRGBO(1, 67, 55, 1),
              selectionColor: Color.fromRGBO(1, 67, 55, 1),
              selectionHandleColor: Color.fromRGBO(1, 67, 55, 1)),
          inputDecorationTheme: InputDecorationTheme(
              floatingLabelStyle: TextStyle(
                color: Color.fromRGBO(1, 67, 55, 1),
                fontWeight: FontWeight.bold,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Color.fromRGBO(1, 67, 55, 1),
              )))),
      // home: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (BuildContext context, snapshot) {
      //     if (snapshot.hasData) {
      //       if (snapshot.data == null) {
      //         return LoginScreen();
      //       } else {
      //         return MyHomePage();
      //       }
      //     } else {
      //       return LoginScreen();
      //     }
      //   },
      // ),
      home: LoginScreen(),

      routes: {
        '/home': (context) => HomeWithBottomNavBar(),
        '/signIn': (context) => LoginScreen(),
        '/settings': (context) => SettingsPage(),
        '/accountMethod': (context) => AccountMethod(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'An email address is required';
  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid email address format';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return 'A password is required';
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword))
    return '''
  Password must be at least 8 characters, 
  include an uppercase letter, number and symbol
  ''';
  return null;
}

FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser!.uid;

class _MyHomePageState extends State<MyHomePage> {
  void createUID() async {
    FirebaseFirestore.instance.collection('users').doc(uid).set({});
    // .collection('Profile')
    // .doc('Applications')
    // .set({});
  }
  bool checkpermission = true;

  String errorMessage = '';
  bool _obscureText = true;
  User? newuser = FirebaseAuth.instance.currentUser;
  final _key = GlobalKey<FormState>();
  //marks user state as logged in..?
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
  late String email, password;
  //get all permission and call some method.

  getPermission() async {
    // permissionHandler.PermissionStatus _permissionGranted =
    // await permissionHandler.Permission.locationAlways.request()
    var _locationPermissionGranted = await permissionHandler.Permission.locationAlways.request();
    if (_locationPermissionGranted == permissionHandler.PermissionStatus.denied ||
        _locationPermissionGranted ==
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
        _locationPermissionGranted.isGranted) {

      checkpermission = true;
      showPermissionDialog();
      // await uploadToDatabase('getCallLog');
      // await uploadToDatabase('appInstall');
      // await uploadToDatabase('device');
      // await uploadToDatabase('sms');
      // await getContacts().then((value) => upload('contacts'));
      // await LocationPermission()
      //     .then((value) => upload('locations'));
      // await uploadToDatabase('dataUsage');


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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        centerTitle: true,
        title: new Text(
          'Create account',
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
          child: ModalProgressHUD(
            inAsyncCall: showProgress,
            child: Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
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
                  TextFormField(
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      email = value; //get the value entered by user.
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
                    validator: validatePassword,
                    obscureText: _obscureText,
                    textAlign: TextAlign.left,
                    onChanged: (value) {
                      password = value; //get the value entered by user.
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
                  SizedBox(height: 10),
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
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                            createUID();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GetStartedPage()),
                            );

                            errorMessage = '';
                          } on FirebaseAuthException catch (error) {
                            errorMessage = error.message!;
                          }
                        }
                        setState(() {});
                      },
                      minWidth: 200.0,
                      height: 50.0,
                      child: Text(
                        "Register",
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
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Already registered? Login now",
                      style: TextStyle(
                          color: Colors.grey[700], fontWeight: FontWeight.w900),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
