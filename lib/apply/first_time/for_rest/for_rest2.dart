import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'for_rest3.dart';

class ApplyForRest2 extends StatefulWidget {
  const ApplyForRest2({Key? key}) : super(key: key);

  @override
  _ApplyForRest3State createState() => _ApplyForRest3State();
}

FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser!.uid;

class _ApplyForRest3State extends State<ApplyForRest2> {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  String stokvelValue = '';
  final TextEditingController stokvelContribution = TextEditingController();

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
      'map2': {
        'Stokvel participation': stokvelValue,
        'Stokvel contribution': stokvelContribution.text,
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
                  SizedBox(height: 20),
                  Container(
                      margin: EdgeInsets.only(right: 60),
                      child: Text('Are you part of a stokvel group?',
                          style: myFont)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Radio(
                      activeColor: Colors.black,
                      value: 'Yes',
                      groupValue: stokvelValue,
                      onChanged: (value) {
                        setState(() {
                          stokvelValue = value as String;
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
                  Row(children: [
                    Radio(
                        activeColor: Colors.black,
                        value: 'No',
                        groupValue: stokvelValue,
                        onChanged: (value) {
                          setState(() {
                            stokvelValue = value as String;
                          });
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    Text('No', style: myFont)
                  ]),
                  SizedBox(height: 10),
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text('How much is contributed on a regular basis?',
                          style: myFont)),
                  SizedBox(width: 4),
                  SizedBox(
                    width: 250,
                  ),
                  TextField(
                    controller: stokvelContribution,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.all(5),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        )),
                  ),
                  SizedBox(height: 150),
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
            //   'map3': {
            //     'Stokvel participation': stokvelValue,
            //     'Stokvel contribution': stokvelContribution.text,
            //   }
            // });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ApplyForRest3()));
          }),
    );
  }
}
