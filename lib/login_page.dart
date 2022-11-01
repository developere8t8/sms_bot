import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:sms_demo/welcome_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  final form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //
    return Title(
        title: 'SMS | Flavoron51.com',
        color: Colors.blue,
        child: Scaffold(
          appBar: AppBar(
            title: Text('LogIn'),
            centerTitle: true,
            backgroundColor: Color(0xffAACE44),
            automaticallyImplyLeading: false,
          ),
          body: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 80, right: 80),
            child: Form(
              key: form_key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image(
                    image: AssetImage('assets/logo.png'),
                    width: 400,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 500,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "Type your Email",
                              fillColor: Colors.white70),
                          controller: emailC,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required Field';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "Type your Password",
                              fillColor: Colors.white70),
                          controller: passwordC,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required Field';
                            }
                            return null;
                          },
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
                        if (form_key.currentState!.validate()) {
                          try {
                            UserCredential userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailC.text, password: passwordC.text);
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => WelcomePage()));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(e.toString()),
                                      actions: [CloseButton()],
                                    );
                                  });
                            } else if (e.code == 'wrong-password') {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(e.toString()),
                                      actions: [CloseButton()],
                                    );
                                  });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(e.code.toString()),
                                      actions: [CloseButton()],
                                    );
                                  });
                            }
                          }
                        }
                      },
                      child: Text(
                        'LogIn',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
        ));
  }
}
