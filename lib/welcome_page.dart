import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_demo/login_page.dart';
import 'package:sms_demo/reset_password.dart';
import 'package:sms_demo/signup_page.dart';
import 'package:sms_demo/sms_boot_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffAACE44),
        automaticallyImplyLeading: false,
        title: Text('Welcome'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogInPage()));
                },
                icon: Icon(Icons.logout_outlined)),
          )
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(left: 80, right: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Image(
              image: AssetImage('assets/logo.png'),
              width: 400,
              height: 200,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 55,
              width: 500,
              decoration:
                  BoxDecoration(color: Colors.orange[400], borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SmsBootPage()));
                },
                child: Text(
                  'Send Sms',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 55,
              width: 500,
              decoration:
                  BoxDecoration(color: Color(0xff975FA2), borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text(
                  'Create User',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 55,
              width: 500,
              decoration:
                  BoxDecoration(color: Color(0xff975FA2), borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPassword()));
                },
                child: Text(
                  'Reset Password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
