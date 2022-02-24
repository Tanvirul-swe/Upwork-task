import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'for_sme2.dart';

class ApplyForSME1 extends StatefulWidget {
  const ApplyForSME1({Key? key}) : super(key: key);

  @override
  _ApplyForSME1State createState() => _ApplyForSME1State();
}

FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser!.uid;

class _ApplyForSME1State extends State<ApplyForSME1> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  final TextEditingController businessOffering = TextEditingController();
  final TextEditingController durationOfOperation = TextEditingController();
  String financingValue = '';

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
      'map a': {
        'Business offering': businessOffering.text,
        'Length of operation': durationOfOperation.text,
        'Source of financing': financingValue,
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
                      margin: EdgeInsets.only(right: 40),
                      child: Text(
                          'What services/products does your business offer?',
                          style: myFont)),
                  SizedBox(width: 4),
                  SizedBox(
                    width: 250,
                  ),
                  TextField(
                    controller: businessOffering,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(5),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )),
                  ),
                  SizedBox(height: 10),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                          'How long has your business been operational?',
                          style: myFont)),
                  SizedBox(width: 4),
                  SizedBox(
                    width: 250,
                  ),
                  TextField(
                    controller: durationOfOperation,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(5),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )),
                  ),
                  SizedBox(height: 10),
                  Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Text('How did you finance your business?',
                          style: myFont)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'Personal savings',
                      groupValue: financingValue,
                      onChanged: (value) {
                        setState(() {
                          financingValue = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Personal savings',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                        activeColor: Colors.black,
                        value: 'Group savings/stokvel',
                        groupValue: financingValue,
                        onChanged: (value) {
                          setState(() {
                            financingValue = value as String;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Group savings/stokvel', style: myFont)
                  ]),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'Friends/family',
                      groupValue: financingValue,
                      onChanged: (value) {
                        setState(() {
                          financingValue = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Friends/family',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'Bank loan',
                      groupValue: financingValue,
                      onChanged: (value) {
                        setState(() {
                          financingValue = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Bank loan',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'Other',
                      groupValue: financingValue,
                      onChanged: (value) {
                        setState(() {
                          financingValue = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Other', style: myFont)
                  ]),
                ],
              ),
            ),
            Container(alignment: Alignment.center, child: Text('2/5'))
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
            //   'map a': {
            //     'Business offering': businessOffering.text,
            //     'Length of operation': durationOfOperation.text,
            //     'Source of financing': financingValue,
            //   }
            // });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ApplyForSME2()));
          }),
    );
  }
}
