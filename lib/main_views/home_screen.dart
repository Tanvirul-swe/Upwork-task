import 'package:csvmethodchannel/apply/first_time/apply_splash.dart';
import 'package:csvmethodchannel/apply/first_time/for_sme/for_sme4.dart';
import 'package:csvmethodchannel/main_views/help.dart';
import 'package:csvmethodchannel/main_views/pay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'status.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // style
    var cardTextStyle = TextStyle(
        fontFamily: 'Poppins',
        letterSpacing: 1.2,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        height: 1);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        title: new Text(
          'Home',
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 25,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(bottom: 1),
                  ),
                  Expanded(
                    child: Center(
                      child: GridView.count(
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        primary: false,
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: InkWell(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                print(prefs.getBool("first-time"));
                                if (prefs.getBool("first-time") != null) {
                                  if (prefs.getBool("first-time")!) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                // LoanApplicationScreen()));
                                                // builder: (context) => ApplyForSME4()));
                                                ApplyForSME4()));
                                  }
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              // LoanApplicationScreen()));
                                              // builder: (context) => ApplyForSME4()));
                                              ApplySplash()));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image:
                                        AssetImage('assets/images/apply.png'),
                                    height: 128,
                                  ),
                                  Text(
                                    'Apply',
                                    style: cardTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StatusScreen()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image:
                                        AssetImage('assets/images/status.png'),
                                    height: 128,
                                  ),
                                  Text(
                                    'Status',
                                    style: cardTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PayScreen()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage('assets/images/pay.png'),
                                    height: 128,
                                  ),
                                  Text(
                                    'Pay',
                                    style: cardTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HelpScreen()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage('assets/images/help.png'),
                                    height: 128,
                                  ),
                                  Text(
                                    'Help',
                                    style: cardTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
