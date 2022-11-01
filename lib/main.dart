import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_demo/login_page.dart';
import 'package:flutter/material.dart';
import 'package:sms_demo/signup_page.dart';
import 'package:sms_demo/sms_boot_page.dart';
import 'package:sms_demo/welcome_page.dart';
import 'package:url_strategy/url_strategy.dart';

Future main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBR1-X1HpC0rzE4D-Yq4ACxyQxWfya0nbQ",
          authDomain: "smsdemo-91412.firebaseapp.com",
          projectId: "smsdemo-91412",
          storageBucket: "smsdemo-91412.appspot.com",
          messagingSenderId: "993537709774",
          appId: "1:993537709774:web:d721fb081bb81668c6e29f"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'SMS Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const LogInPage(),
            ));
  }
}
