import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csvmethodchannel/main_views/home_with_bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplyForSME4 extends StatefulWidget {
  const ApplyForSME4({Key? key}) : super(key: key);

  @override
  _ApplyForSME3State createState() => _ApplyForSME3State();
}

FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser!.uid;

class _ApplyForSME3State extends State<ApplyForSME4> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  String loanType = '';
  final TextEditingController loanDetails = TextEditingController();
  final TextEditingController loanAmount = TextEditingController();

  var myFont = (TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.bold));

  void uploadLoanApplication() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Loan requests')
        .doc()
        .set({
      'Loan type': loanType,
      'Loan details': loanDetails.text,
      'Amount requested': loanAmount.text,
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
                          'Are you applying for a personal or business loan?',
                          style: myFont)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'Personal',
                      groupValue: loanType,
                      onChanged: (value) {
                        setState(() {
                          loanType = value as String;
                        });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Personal',
                      style: myFont,
                    )
                  ]),
                  Row(children: [
                    Radio(
                        activeColor: Colors.black,
                        value: 'Business',
                        groupValue: loanType,
                        onChanged: (value) {
                          setState(() {
                            loanType = value as String;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Business', style: myFont)
                  ]),
                  SizedBox(height: 10),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                          'Please state the purpose of the loan in as much detail as possible',
                          style: myFont)),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                  ),
                  TextField(
                    controller: loanDetails,
                    maxLines: 5,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        isDense: false,
                        contentPadding: const EdgeInsets.all(5),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )),
                  ),
                  SizedBox(height: 20),
                  Container(
                      margin: EdgeInsets.only(right: 32),
                      child: Text('How much are you looking to borrow?',
                          style: myFont)),
                  SizedBox(height: 10),
                  TextField(
                    controller: loanAmount,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        isDense: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FutureBuilder(
                    builder:
                        (context, AsyncSnapshot<SharedPreferences> snapshot) {
                      if (snapshot.hasData) {
                        var firstTime = snapshot.data!.getBool("first-time");
                        if (snapshot.hasData) if (firstTime != null &&
                            firstTime) {
                          return SizedBox();
                        }
                        return Container(
                            margin: EdgeInsets.only(right: 75),
                            child: Text('5/5'));
                      }
                      return SizedBox();
                    },
                    future: SharedPreferences.getInstance()),
                Container(
                  margin: EdgeInsets.only(right: 40),
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(1, 67, 55, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool("first-time", true);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              AlertDialog dialog = AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  content: Container(
                                    height: 200,
                                    width: 200,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                              image: AssetImage(
                                                  'assets/images/mail.png')),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('Submitted',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey)),
                                          SizedBox(height: 15),
                                          Text('Application pending',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          SizedBox(height: 15),
                                          Text(
                                              "We'll notify you of your status within the next 24 hours",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        ]),
                                  ),
                                  actions: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color.fromRGBO(
                                                        1, 67, 55, 1)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                          ),
                                          child: Text('Finish'),
                                          onPressed: () async {
                                            uploadLoanApplication();
                                            //  await collectionReference
                                            //       .doc(collectionReference
                                            //           .doc('Loan applications')
                                            //           .id).collection('Loan details')
                                            //       .add({
                                            //     'Loan type': loanType,
                                            //     'Loan details': loanDetails.text,
                                            //     'Amount requested': loanAmount.text,
                                            //   });

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        HomeWithBottomNavBar()));
                                          }),
                                    )
                                  ]);
                              return dialog;
                            });
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
