import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30,
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        toolbarHeight: 100,
        title: new Text(
          'Help',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 25,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(40),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                      child: Text("Have a question? We're here to help",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/whatsapp.png'))),
                          SizedBox(width: 20),
                          Container(child: Text('Whatsapp support'))
                        ]),
                  ),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () {},
                    child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Image(
                                  image:
                                      AssetImage('assets/images/globe.png'))),
                          SizedBox(
                            width: 20,
                          ),
                          Container(child: Text('Frequently asked questions'))
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(40.0),
            child: Container(
                child: Text(
              'Follow us on social media',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {},
                  child:
                      Image(image: AssetImage('assets/images/facebook.png'))),
              SizedBox(
                width: 30,
              ),
              InkWell(
                  onTap: () {},
                  child: Image(image: AssetImage('assets/images/linkedin.png')))
            ],
          )
        ],
      ),
    );
  }
}
