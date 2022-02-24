import 'package:csvmethodchannel/registration/verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

class GetStartedPage extends StatefulWidget {
  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser!.uid;

class _GetStartedPageState extends State<GetStartedPage> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController id = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    gender.text = "Male";
    super.initState();
  }

  void uploadPersonalDetails() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Profile')
        .doc('Personal details')
        .set({
      'First name': firstName.text,
      'Last name': lastName.text,
      'Gender': gender.text,
      'Date of birth': dateOfBirth.text,
      'ID': id.text,
      'Address': address.text,
      'Mobile number': mobileNumber.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(1, 67, 55, 1),
            centerTitle: true,
            title: new Text(
              'Get started',
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  height: 1),
            ),
          ),
          body: Container(
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            controller: firstName,
                            decoration: InputDecoration(
                                labelText: 'First Name',
                                floatingLabelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                                border: _underlineBorder(),
                                enabledBorder: _underlineBorder(),
                                focusedBorder: _underlineBorder()),
                            validator: (value) {
                              if (value == "") {
                                return "required";
                              }
                              return null;
                            }),
                        TextFormField(
                            controller: lastName,
                            decoration: InputDecoration(
                                labelText: 'Last Name',
                                floatingLabelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                                border: _underlineBorder(),
                                enabledBorder: _underlineBorder(),
                                focusedBorder: _underlineBorder()),
                            validator: (value) {
                              if (value == "") {
                                return "required";
                              }
                              return null;
                            }),
                        GestureDetector(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(Duration(days: 36500)),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              print(value);
                              var date = DateFormat.yMd().format(value!);
                              setState(() {
                                dateOfBirth.text = date.toString();
                              });
                            });
                          },
                          child: Theme(
                            data: ThemeData(
                              disabledColor: Colors.black.withAlpha(160),
                            ),
                            child: TextFormField(
                                controller: dateOfBirth,
                                enabled: false,
                                decoration: InputDecoration(
                                    labelText: 'Date of birth',
                                    hintText: 'dd/mm/yyyy',
                                    floatingLabelStyle: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: _underlineBorder(),
                                    enabledBorder: _underlineBorder(),
                                    focusedBorder: _underlineBorder()),
                                validator: (value) {
                                  if (value == "") {
                                    return "required";
                                  }
                                  return null;
                                }),
                          ),
                        ),
                        DropdownButtonFormField<String>(
                            value: "Male",
                            items: ["Male", "Female"]
                                .map((e) => DropdownMenuItem<String>(
                                    child: Text(e), value: e))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                gender.text = value;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Gender',

                              floatingLabelStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                              // border: _underlineBorder(),
                              // enabledBorder: _underlineBorder(),
                              // focusedBorder: _underlineBorder()
                            ),
                            validator: (value) {
                              if (value == "") {
                                return "required";
                              }
                              return null;
                            }),
                        TextFormField(
                            controller: id,
                            decoration: InputDecoration(
                                labelText: 'ID number',
                                floatingLabelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                                border: _underlineBorder(),
                                enabledBorder: _underlineBorder(),
                                focusedBorder: _underlineBorder()),
                            validator: (value) {
                              if (value == "") {
                                return "required";
                              }
                              return null;
                            }),
                        TextFormField(
                            controller: address,
                            decoration: InputDecoration(
                                labelText: 'Address',
                                hintText:
                                    '102 Arnd St, Bloemfontein, Free State',
                                floatingLabelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                                border: _underlineBorder(),
                                enabledBorder: _underlineBorder(),
                                focusedBorder: _underlineBorder()),
                            validator: (value) {
                              if (value == "") {
                                return "required";
                              }
                              return null;
                            }),
                        TextFormField(
                            controller: mobileNumber,
                            decoration: InputDecoration(
                                labelText: 'Mobile number',
                                floatingLabelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                                border: _underlineBorder(),
                                enabledBorder: _underlineBorder(),
                                focusedBorder: _underlineBorder()),
                            validator: (value) {
                              if (value == "") {
                                return "required";
                              }
                              return null;
                            }),
                      ],
                    ),
                  )),
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
              if (_formKey.currentState!.validate()) {
                uploadPersonalDetails();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VerificationPage()),
                );
              }
              // await collectionReference
              //     .doc(collectionReference.doc(uid).id)
              //     .set({
              //   'First name': firstName.text,
              //   'Last name': lastName.text,
              //   'Gender': gender.text,
              //   'Date of birth': dateOfBirth.text,
              //   'ID': id.text,
              //   'Address': address.text,
              //   'Mobile number': mobileNumber.text
              // });

              //   await collectionReference
              //       .doc(collectionReference.doc('Personal details').id)
              //       .set({
              //     'First name': firstName.text,
              //     'Last name': lastName.text,
              //     'Gender': gender.text,
              //     'Date of birth': dateOfBirth.text,
              //     'ID': id.text,
              //     'Address': address.text,
              //     'Mobile number': mobileNumber.text
              //   });
            },
          )),
    );
  }

  UnderlineInputBorder _underlineBorder() {
    return UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor));
  }
}
