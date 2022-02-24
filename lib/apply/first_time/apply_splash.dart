import 'package:csvmethodchannel/apply/first_time/apply1.dart';
import 'package:flutter/material.dart';

class ApplySplash extends StatelessWidget {
  const ApplySplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 30,
          elevation: 0,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 100,
          title: new Text(
            'Apply',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 25,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                height: 1),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(children: [
            Container(
                child: Image(image: AssetImage('assets/images/undraw.png'))),
            Container(
                margin: EdgeInsets.all(20),
                child: Text('Fast, affordable loans in minutes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold))),
            SizedBox(
              height: 1,
            ),
            Container(
                margin: EdgeInsets.all(15),
                child: Text(
                  'Tell us about yourself by answering a series of questions, receive a loan outcome in under an hour and get cash to your account once approved.',
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ApplyScreen1()));},
              child: Text('Get started',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins')),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
               
                  ),
            ),
          ]),
        ));
  }
}
