import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csvmethodchannel/main_views/account_method.dart';
import 'package:csvmethodchannel/main_views/password_reset_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String errorMessage = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> db;

  @override
  void initState() {
    super.initState();
    uid = _auth.currentUser!.uid;
    db = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Profile')
        .doc('Personal details')
        .snapshots();
  }

  var boldFont = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        title: new Text(
          'Settings',
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
          padding: EdgeInsets.all(10),
          color: Color.fromRGBO(246, 246, 246, 1),
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(),
                child: Text('Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter'))),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('First name'),
                        StreamBuilder<DocumentSnapshot>(
                          stream: db,
// stream: db,
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError)
                              return Text('Something went wrong');
                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              return CircularProgressIndicator();

                            dynamic data = snapshot.data!.data();
                            return Text(data['First name'], style: boldFont);
                          },
                        ),
                      ]),
                  Divider(color: Colors.black),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Last name'),
                      SizedBox(width: 40),
                      StreamBuilder<DocumentSnapshot>(
                        stream: db,
// stream: db,
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError)
                            return Text('Something went wrong');
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return CircularProgressIndicator();

                          dynamic data = snapshot.data!.data();
                          return Text(data['Last name'], style: boldFont);
                        },
                      ),
                    ],
                  ),
                  Divider(color: Colors.black),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PasswordResetScreen(),
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Change password'),
                        SizedBox(width: 40),
                        Icon(Icons.arrow_forward, size: 18, color: Colors.black)
                      ],
                    ),
                  ),
                  Divider(color: Colors.black),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountMethod()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Accounts'),
                        SizedBox(width: 40),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size: 19.0,
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.black),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(1, 67, 55, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                      ),
                      child: Text('Log out'),
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                          errorMessage = '';
                        } on FirebaseAuthException catch (error) {
                          errorMessage = error.message!;
                        }
                        Navigator.of(context).pushReplacementNamed('/signIn');
                        setState(() {});
                      }),
                  SizedBox(height: 15),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
