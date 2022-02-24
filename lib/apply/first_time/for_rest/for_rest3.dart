import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'for_rest4.dart';

class ApplyForRest3 extends StatefulWidget {
  const ApplyForRest3({Key? key}) : super(key: key);

  @override
  _ApplyForRest3State createState() => _ApplyForRest3State();
}

FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser!.uid;

class _ApplyForRest3State extends State<ApplyForRest3> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  String education = '';
  String monthlySavings = '';

  var myFont = (TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.bold));

  void uploadBackgroundInfo() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Profile')
        .doc('Background information')
        .update({
      'map3': {
        'Highest level of education': education,
        'Monthly savings': monthlySavings,
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        toolbarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              margin: EdgeInsets.only(
                left: 20,
                top: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Text('What is your highest level of education?',
                          style: myFont)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'Postgraduate',
                      groupValue: education,
                      onChanged: (value) {
                        setState(() {
                          education = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Postgraduate',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                        activeColor: Colors.black,
                        value: 'Undergraduate',
                        groupValue: education,
                        onChanged: (value) {
                          setState(() {
                            education = value as String;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Undergratuate', style: myFont)
                  ]),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'Matric',
                      groupValue: education,
                      onChanged: (value) {
                        setState(() {
                          education = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Matric',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'Elementary',
                      groupValue: education,
                      onChanged: (value) {
                        setState(() {
                          education = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Elementary',
                      style: myFont,
                    )
                  ]),
                  SizedBox(height: 20),
                  Container(
                      margin: EdgeInsets.only(right: 60),
                      child: Text('How much do you save per month?',
                          style: myFont)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'R1 - R99',
                      groupValue: monthlySavings,
                      onChanged: (value) {
                        setState(() {
                          monthlySavings = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'R1 - R99',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                        activeColor: Colors.black,
                        value: 'R100 - R249',
                        groupValue: monthlySavings,
                        onChanged: (value) {
                          setState(() {
                            monthlySavings = value as String;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text('R100 - R249', style: myFont)
                  ]),
                  Row(children: [
                    Radio(
                        activeColor: Colors.black,
                        value: 'R250 - R499',
                        groupValue: monthlySavings,
                        onChanged: (value) {
                          setState(() {
                            monthlySavings = value as String;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text('R250 - R499', style: myFont)
                  ]),
                  Row(children: [
                    Radio(
                        activeColor: Colors.black,
                        value: 'R500 and above',
                        groupValue: monthlySavings,
                        onChanged: (value) {
                          setState(() {
                            monthlySavings = value as String;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text('R500 and above', style: myFont)
                  ]),
                  Row(children: [
                    Radio(
                        activeColor: Colors.black,
                        value: 'Not yet',
                        groupValue: monthlySavings,
                        onChanged: (value) {
                          setState(() {
                            monthlySavings = value as String;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Not yet', style: myFont)
                  ]),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Container(alignment: Alignment.center, child: Text('4/5'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 1,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.black,
          ),
          onPressed: () async {
            uploadBackgroundInfo();
            // await collectionReference
            //     .doc(collectionReference.doc('Applicant particulars').id)
            //     .update({
            //   'map4': {
            //     'Highest level of education': education,
            //     'Monthly savings': monthlySavings,
            //   }
            // });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ApplyForRest4()));
          }),
    );
  }
}
