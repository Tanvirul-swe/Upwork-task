// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class MessagesScreen extends StatefulWidget {
//   @override
//   MessagesScreenState createState() => MessagesScreenState();
// }

// FirebaseAuth _auth = FirebaseAuth.instance;
// final uid = _auth.currentUser!.uid;
// var boldFont = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600);

// class MessagesScreenState extends State<MessagesScreen> {
//   final db = FirebaseFirestore.instance
//       .collection('users')
//       .doc(uid)
//       .collection('Messages')
//       .doc('Loans approved')
//       .collection('Loans approved')
//       .snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           titleSpacing: 30,
//           automaticallyImplyLeading: false,
//           backgroundColor: Color.fromRGBO(1, 67, 55, 1),
//           toolbarHeight: 100,
//           title: new Text(
//             'Messages',
//             style: TextStyle(
//                 color: Color.fromRGBO(255, 255, 255, 1),
//                 fontFamily: 'Poppins',
//                 fontSize: 25,
//                 letterSpacing: 1.2,
//                 fontWeight: FontWeight.bold,
//                 height: 1),
//           ),
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//           stream: db,
//           builder: (context, snapshot) {
//             if (!snapshot.hasData)
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             return ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   // return snapshot.data!.docs[index].data()![''];
//                   return snapshot.data!.docs[index]['Loan amount'];
//                 });
//           },
//         ));
//   }
// }

