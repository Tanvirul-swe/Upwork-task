import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'for_rest2.dart';

class ApplyForRest1 extends StatefulWidget {
  const ApplyForRest1({Key? key}) : super(key: key);

  @override
  _ApplyForRest1State createState() => _ApplyForRest1State();
}

FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser!.uid;

class _ApplyForRest1State extends State<ApplyForRest1> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  String incomeSourceValue = '';
  final TextEditingController monthlyIncome = TextEditingController();
  final TextEditingController monthlyExpenses = TextEditingController();

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
      'map1': {
        'Income source': incomeSourceValue,
        'Monthly income': monthlyIncome.text,
        'Monthly expenses': monthlyExpenses.text
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
                      child: Text('What is your main source of income?',
                          style: myFont)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'Salary',
                      groupValue: incomeSourceValue,
                      onChanged: (value) {
                        setState(() {
                          incomeSourceValue = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Salary',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                        activeColor: Colors.black,
                        value: 'Savings',
                        groupValue: incomeSourceValue,
                        onChanged: (value) {
                          setState(() {
                            incomeSourceValue = value as String;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Savings', style: myFont)
                  ]),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'Inheritance/Allowance',
                      groupValue: incomeSourceValue,
                      onChanged: (value) {
                        setState(() {
                          incomeSourceValue = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Inheritance/Allowance',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'Investments',
                      groupValue: incomeSourceValue,
                      onChanged: (value) {
                        setState(() {
                          incomeSourceValue = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Investments',
                      style: myFont,
                    )
                  ]),
                  SizedBox(height: 20),
                  Container(
                      margin: EdgeInsets.only(right: 40),
                      child: Text('How much is your monthly income?',
                          style: myFont)),
                  SizedBox(width: 4),
                  SizedBox(
                    width: 250,
                  ),
                  Container(
                    width: 270,
                    margin: EdgeInsets.only(right: 18),
                    child: TextField(
                      controller: monthlyIncome,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.all(5),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          )),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text("How much are your monthly expenses?",
                          style: myFont)),
                  SizedBox(width: 4),
                  Container(
                    width: 270,
                    margin: EdgeInsets.only(right: 20),
                    child: TextField(
                      controller: monthlyExpenses,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.all(5),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          )),
                    ),
                  ),
                  SizedBox(height: 30),
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
            //   'map2': {
            //     'Income source': incomeSourceValue,
            //     'Monthly income': monthlyIncome.text,
            //     'Monthly expenses': monthlyExpenses.text
            //   }
            // });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ApplyForRest2()));
          }),
    );
  }
}
