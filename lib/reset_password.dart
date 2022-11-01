import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  TextEditingController emaiC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffAACE44),
        title: Text('Reset Password'),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 80, right: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 500,
              child: Column(
                children: [
                  TextFormField(
                    controller: emaiC,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Type your Email",
                        fillColor: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              height: 55,
              width: 500,
              decoration:
                  BoxDecoration(color: Color(0xff975FA2), borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: emaiC.text);
                },
                child: Text(
                  'Reset Password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text("Note:If you did not found Email in your inbox then please check the spam folder ")
          ],
        ),
      )),
    );
  }
}
