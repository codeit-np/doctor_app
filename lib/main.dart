import 'package:doctor_app/pages/client/dashboard.dart';
import 'package:doctor_app/pages/intro.dart';
import 'package:doctor_app/pages/login.dart';
import 'package:doctor_app/pages/signup.dart';
import 'package:doctor_app/pages/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor on Hand',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => SplashScreen(),
        "intro": (context) => IntroScreen(),
        "login": (context) => LoginScreen(),
        "signup": (context) => SignupScreen(),
        "clientdashboard": (context) => ClientDashboard(),
      },
    );
  }
}
