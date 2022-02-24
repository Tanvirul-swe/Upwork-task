import 'package:csvmethodchannel/main_views/bank_account_method.dart';
import 'package:csvmethodchannel/main_views/mtn_account_method.dart';
import 'package:flutter/material.dart';


class AccountMethod extends StatefulWidget {
  @override
  AccountMethodState createState() => AccountMethodState();
}

class AccountMethodState extends State<AccountMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 30,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/home');
          },
        ),
        backgroundColor: Color.fromRGBO(1, 67, 55, 1),
        title: new Text(
          'Accounts',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontSize: 25,
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              height: 1),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(40),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40)),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                      margin: EdgeInsets.only(right: 69),
                      child: Text('Payment methods',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MTNAccountMethod()));
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Image(
                                  image: AssetImage('assets/images/mtn.png'))),
                          SizedBox(
                            width: 25,
                          ),
                          Container(child: Text('MTN Mobile Money'))
                        ]),
                  ),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BankAccountMethod()));
                    },
                    child: Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 68),
                              child: Image(
                                  image:
                                      AssetImage('assets/images/stdbank.png'))),
                          SizedBox(
                            width: 35,
                          ),
                          Container(child: Text('EFT Transfer'))
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(40.0),
            child: Container(
                child: Text(
              'Please note that we do not accept cash deposits or cheques.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            )),
          )
        ],
      ),
    );
  }
}
