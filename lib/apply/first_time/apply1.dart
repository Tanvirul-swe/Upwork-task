import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csvmethodchannel/apply/first_time/for_rest/for_rest1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'for_sme/for_sme1.dart';

class ApplyScreen1 extends StatefulWidget {
  const ApplyScreen1({Key? key}) : super(key: key);

  @override
  _ApplyScreen1State createState() => _ApplyScreen1State();
}

class _ApplyScreen1State extends State<ApplyScreen1> {
  String creditScoreValue = '';
  String smallBusinessOwnerValue = '';
  String employmentStatusValue = '';
  final TextEditingController creditScoreAmount = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid;

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  bool _isVisible = false;
  bool _isVisible2 = false;
  bool _forBusiness = true;

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
        .set({
      'Is credit score present?': creditScoreValue,
      'Credit score value': creditScoreAmount.text,
      'Is small business owner?': smallBusinessOwnerValue,
      'Employment status': employmentStatusValue,
    });
  }

  @override
  void initState() {
    super.initState();
    uid = _auth.currentUser!.uid;
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 40, bottom: 40),
                margin: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: 100),
                        child:
                            Text('Do you have a credit score?', style: myFont)),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(children: [
                        Radio(
                          activeColor: Colors.black,
                          value: 'Yes',
                          groupValue: creditScoreValue,
                          onChanged: (value) {
                            setState(() {
                              creditScoreValue = value as String;
                              _isVisible = true;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Yes',
                          style: myFont,
                        )
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(children: [
                        Radio(
                            activeColor: Colors.black,
                            value: 'No',
                            groupValue: creditScoreValue,
                            onChanged: (value) {
                              setState(() {
                                creditScoreValue = value as String;
                                _isVisible = false;
                              });
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        Text('No', style: myFont)
                      ]),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.only(right: 112),
                      child: Visibility(
                        visible: _isVisible,
                        child:
                            Text('What is your credit score?', style: myFont),
                      ),
                    ),
                    SizedBox(width: 4),
                    SizedBox(
                      width: 300,
                      child: Visibility(
                        visible: _isVisible,
                        child: TextField(
                          controller: creditScoreAmount,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.all(5),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                        margin: EdgeInsets.only(right: 60),
                        child: Text('Are you a small business owner?',
                            style: myFont)),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(children: [
                        Radio(
                          activeColor: Colors.black,
                          value: 'Yes',
                          groupValue: smallBusinessOwnerValue,
                          onChanged: (value) {
                            setState(() {
                              smallBusinessOwnerValue = value as String;
                              _forBusiness = true;
                              _isVisible2 = false;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Yes',
                          style: myFont,
                        )
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(children: [
                        Radio(
                            activeColor: Colors.black,
                            value: 'No',
                            groupValue: smallBusinessOwnerValue,
                            onChanged: (value) {
                              setState(() {
                                smallBusinessOwnerValue = value as String;
                                _forBusiness = false;
                                _isVisible2 = true;
                              });
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        Text('No', style: myFont),
                      ]),
                    ),
                    SizedBox(height: 10),
                    Container(
                        margin: EdgeInsets.only(right: 56),
                        child: Visibility(
                            visible: _isVisible2,
                            child: Text('What is your employment status?',
                                style: myFont))),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: _isVisible2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(children: [
                          Radio(
                            activeColor: Colors.black,
                            value: 'Unemployed',
                            groupValue: employmentStatusValue,
                            onChanged: (value) {
                              setState(() {
                                employmentStatusValue = value as String;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Unemployed',
                            style: myFont,
                          )
                        ]),
                      ),
                    ),
                    Visibility(
                      visible: _isVisible2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(children: [
                          Radio(
                            activeColor: Colors.black,
                            value: 'Employed',
                            groupValue: employmentStatusValue,
                            onChanged: (value) {
                              setState(() {
                                employmentStatusValue = value as String;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Employed',
                            style: myFont,
                          )
                        ]),
                      ),
                    ),
                    Visibility(
                      visible: _isVisible2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(children: [
                          Radio(
                            activeColor: Colors.black,
                            value: 'Freelancer',
                            groupValue: employmentStatusValue,
                            onChanged: (value) {
                              setState(() {
                                employmentStatusValue = value as String;
                                _isVisible = _isVisible;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Freelancer',
                            style: myFont,
                          )
                        ]),
                      ),
                    ),
                    Visibility(
                      visible: _isVisible2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(children: [
                          Radio(
                            activeColor: Colors.black,
                            value: 'Student',
                            groupValue: employmentStatusValue,
                            onChanged: (value) {
                              setState(() {
                                employmentStatusValue = value as String;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Student',
                            style: myFont,
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(alignment: Alignment.center, child: Text('1/5'))
            ]),
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

            if (_forBusiness) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ApplyForSME1()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ApplyForRest1()));
            }
          }),
    );
  }
}
