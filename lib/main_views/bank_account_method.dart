import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BankAccountMethod extends StatefulWidget {
  const BankAccountMethod({Key? key}) : super(key: key);

  @override
  _BankAccountMethodState createState() => _BankAccountMethodState();
}

class _BankAccountMethodState extends State<BankAccountMethod> {
  final CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Profile");
  final TextEditingController bankName = TextEditingController();
  final TextEditingController accountHolder = TextEditingController();
  final TextEditingController accountType = TextEditingController();
  final TextEditingController branchCode = TextEditingController();
  final TextEditingController accountNumber = TextEditingController();

  final Stream<DocumentSnapshot<Map<String, dynamic>>> db = FirebaseFirestore
      .instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Profile")
      .doc('Bank details')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/accountMethod');
          },
        ),
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: new Text(
          'Bank account details',
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontFamily: 'Poppins',
              fontSize: 25,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Form(
                      child: StreamBuilder<DocumentSnapshot>(
                          stream: db,
                          builder: (context, snapshot) {
                            if (snapshot.hasError)
                              return Text('Something went wrong');
                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              return CircularProgressIndicator();

                            dynamic data = snapshot.data!.data();
                            if (data != null) {
                              // return Text("No bank account detail found");
                              bankName.text = data['Bank name'] ?? '';
                              accountHolder.text = data['Account holder'] ?? '';
                              accountType.text = data['Account type'] ?? '';
                              branchCode.text = data['Branch code'] ?? '';
                              accountNumber.text = data['Account number'] ?? '';
                            }

                            return Column(
                              children: <Widget>[
                                TextField(
                                  controller: bankName,
                                  decoration: InputDecoration(
                                    labelText: 'Bank name',
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                                TextField(
                                  controller: accountHolder,
                                  decoration: InputDecoration(
                                    labelText: 'Account holder',
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                                TextField(
                                  controller: accountType,
                                  decoration: InputDecoration(
                                    labelText: 'Account type',
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                                TextField(
                                  controller: branchCode,
                                  decoration: InputDecoration(
                                    labelText: 'Branch code',
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                                TextField(
                                  controller: accountNumber,
                                  decoration: InputDecoration(
                                    labelText: 'Account number',
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ],
                            );
                          }),
                    )),
              ),
            ),
            ElevatedButton(
                child: Text('Save changes',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins')),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                onPressed: () async {
                  await collectionReference.doc('Bank details').update({
                    'Bank name': bankName.text,
                    'Account holder': accountHolder.text,
                    'Account type': accountType.text,
                    'Branch code': branchCode.text,
                    'Account number': accountNumber.text,
                  });
                  Navigator.of(context).pushReplacementNamed('/home');
                }),
          ],
        ),
      ),
    );
  }
}
