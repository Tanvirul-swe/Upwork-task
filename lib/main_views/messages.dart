import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MessagesScreen extends StatefulWidget {
  @override
  MessagesScreenState createState() => MessagesScreenState();
}

var boldFont = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600);

class MessagesScreenState extends State<MessagesScreen> {
  String errorMessage = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid;
  late Stream<QuerySnapshot<Map<String, dynamic>>> db;

  @override
  void initState() {
    super.initState();
    uid = _auth.currentUser!.uid;
    db = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Messages')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 30,
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(1, 67, 55, 1),
          title: new Text(
            'Messages',
            style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'Poppins',
                fontSize: 25,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                height: 1),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: StreamBuilder<QuerySnapshot>(
              stream: db,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text('Something went wrong');
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                      width: 30,
                      height: 30,
                    ),
                  );

                QuerySnapshot? data = snapshot.data;

                if (data == null) {
                  return Text("No messsages");
                } else {
                  return ListView(
                    children: data.docs
                        .map(
                          (e) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8.0),
                                title: Text(
                                  e['Status'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(DateFormat("DD MM yyyy").format(
                                      (e['date_time'] as Timestamp).toDate())),
                                ),
                                trailing: Text(e['amount']),
                              ),
                              Divider(
                                color: Colors.black54,
                              )
                            ],
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          ),
        ));
  }
}
