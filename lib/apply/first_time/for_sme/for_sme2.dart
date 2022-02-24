import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'for_sme3.dart';

class ApplyForSME2 extends StatefulWidget {
  const ApplyForSME2({Key? key}) : super(key: key);

  @override
  _ApplyForSME1State createState() => _ApplyForSME1State();
}

FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser!.uid;

class _ApplyForSME1State extends State<ApplyForSME2> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  String investmentToDate = '';
  final TextEditingController monthlyBusinessRevenue = TextEditingController();
  final TextEditingController monthlyBusinessExpenses = TextEditingController();

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
      'map b': {
        'Investment to date': investmentToDate,
        'Business revenue p/m': monthlyBusinessRevenue.text,
        'Business expenses p/m': monthlyBusinessExpenses.text,
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
                      child: Text(
                          'How much has been invested into your business to date?',
                          style: myFont)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'R0 - R2499',
                      groupValue: investmentToDate,
                      onChanged: (value) {
                        setState(() {
                          investmentToDate = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'R0 - R2499',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                        activeColor: Colors.black,
                        value: 'R2500 - R4999',
                        groupValue: investmentToDate,
                        onChanged: (value) {
                          setState(() {
                            investmentToDate = value as String;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text('R2500 - R4999', style: myFont)
                  ]),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'R5000 - R7499',
                      groupValue: investmentToDate,
                      onChanged: (value) {
                        setState(() {
                          investmentToDate = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'R5000 - R7499',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'R7500 - R9999',
                      groupValue: investmentToDate,
                      onChanged: (value) {
                        setState(() {
                          investmentToDate = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'R7500 - R9999',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'R10000 and above',
                      groupValue: investmentToDate,
                      onChanged: (value) {
                        setState(() {
                          investmentToDate = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('R10000 and above', style: myFont)
                  ]),
                  SizedBox(height: 20),
                  Container(
                      margin: EdgeInsets.only(right: 40),
                      child: Text('How much does your business make per month?',
                          style: myFont)),
                  SizedBox(width: 4),
                  SizedBox(
                    width: 250,
                  ),
                  TextField(
                    controller: monthlyBusinessRevenue,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(5),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )),
                  ),
                  SizedBox(height: 20),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text("What are your business's monthly expenses?",
                          style: myFont)),
                  SizedBox(width: 4),
                  SizedBox(
                    width: 250,
                  ),
                  TextField(
                    controller: monthlyBusinessExpenses,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(5),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Container(alignment: Alignment.center, child: Text('3/5'))
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
            //   'map b': {
            //     'Investment to date': investmentToDate,
            //     'Business revenue p/m': monthlyBusinessRevenue.text,
            //     'Business expenses p/m': monthlyBusinessExpenses.text,
            //   }
            // });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ApplyForSME3()));
          }),
    );
  }
}
