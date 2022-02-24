import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class PasswordResetScreen extends StatefulWidget {
  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Text("Add and email address to send password reset link.",
              style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value == "") {
                  return "required";
                } else if (!isEmail(value)) {
                  return "Invalid email address";
                }
                return null;
              },
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailController.text)
                      .onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong, try again"),
                    ));
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Password reset link sent"),
                    ));
                  });
                }
              },
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor))
        ]),
      ),
    );
  }
}
