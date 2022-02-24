import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  _StatusScreenState createState() => _StatusScreenState();
}

var boldFont = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600);

class _StatusScreenState extends State<StatusScreen> {
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
        .collection('Loans approved')
        .doc('Outstanding loan')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30,
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        title: new Text(
          'Status',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 25,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: 550,
            width: 320,
            margin: EdgeInsets.all(40),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: Column(children: [
              SizedBox(height: 30),
              Container(
                  width: 200,
                  height: 200,
                  child: Stack(children: <Widget>[
                    Container(
                        child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              offset: Offset(0, 4),
                              blurRadius: 10)
                        ],
                        color: Color.fromRGBO(255, 255, 255, 1),
                        border: Border.all(
                          color: Color.fromRGBO(243, 243, 243, 1),
                          width: 7,
                        ),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(200, 200)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Outstanding balance',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(
                                        0, 0, 0, 0.699999988079071),
                                    fontFamily: 'Inter',
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              alignment: Alignment.center,
                              child: Column(children: [
                                StreamBuilder<DocumentSnapshot>(
                                  stream: db,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasError)
                                      return Text('Something went wrong');
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting)
                                      return CircularProgressIndicator();

                                    dynamic data = snapshot.data!.data();
                                    var balance = 0.00.toStringAsPrecision(3);

                                    if (data != null) {
                                      balance = data['Outstanding balance'];
                                    }
                                    return Text(
                                      "R $balance",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              0, 0, 0, 0.699999988079071),
                                          fontFamily: 'Inter',
                                          fontSize: 28,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    );
                                  },
                                ),
                              ])),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: StreamBuilder<DocumentSnapshot>(
                              stream: db,
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError)
                                  return Text('Something went wrong');
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                  return CircularProgressIndicator();

                                dynamic data = snapshot.data!.data();
                                var due_date = "";

                                if (data != null) {
                                  due_date = data['Due date'];
                                }
                                return Text(
                                  due_date,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(
                                          0, 0, 0, 0.699999988079071),
                                      fontFamily: 'Inter',
                                      fontSize: 20,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                      height: 1),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )),
                  ])),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 29),
                child: Row(children: [Text('Loan details', style: boldFont)]),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Loan amount'),
                        SizedBox(width: 80),
                        StreamBuilder<DocumentSnapshot>(
                          stream: db,
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError)
                              return Text('Something went wrong');
                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              return CircularProgressIndicator();

                            dynamic data = snapshot.data!.data();
                            var loan_amount = 0.00.toStringAsPrecision(3);

                            if (data != null) {
                              loan_amount = data['Loan amount'];
                            }
                            return Text(
                              "R $loan_amount",
                              style: boldFont,
                            );
                          },
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Interest'),
                      SizedBox(width: 116),
                      StreamBuilder<DocumentSnapshot>(
                        stream: db,
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError)
                            return Text('Something went wrong');
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return CircularProgressIndicator();

                          dynamic data = snapshot.data!.data();
                          var interest = 0.00.toStringAsPrecision(3);

                          if (data != null) {
                            interest = data['Interest'];
                          }
                          return Text(
                            "R $interest",
                            style: boldFont,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Loan term'),
                      SizedBox(width: 100),
                      StreamBuilder<DocumentSnapshot>(
                        stream: db,
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError)
                            return Text('Something went wrong');
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return CircularProgressIndicator();

                          dynamic data = snapshot.data!.data();
                          var loan_term = '';
                          if (data != null) {
                            loan_term = data['Loan term'];
                          }

                          return Text(
                            loan_term,
                            style: boldFont,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Loan date'),
                      SizedBox(width: 116),
                      StreamBuilder<DocumentSnapshot>(
                        stream: db,
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError)
                            return Text('Something went wrong');
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return CircularProgressIndicator();

                          dynamic data = snapshot.data!.data();
                          var loan_date = '';
                          if (data != null) {
                            loan_date = data['Loan date'];
                          }

                          return Text(
                            loan_date,
                            style: boldFont,
                          );
                        },
                      ),
                    ],
                  ),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
            ])),
      ),
    );
  }
}
