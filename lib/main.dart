import 'package:doctor_app/pages/changepassword.dart';
import 'package:doctor_app/pages/client/dashboard.dart';
import 'package:doctor_app/pages/doctorprofile.dart';
import 'package:doctor_app/pages/hospitalprofile.dart';
import 'package:doctor_app/pages/intro.dart';
import 'package:doctor_app/pages/login.dart';
import 'package:doctor_app/pages/signup.dart';
import 'package:doctor_app/pages/splash.dart';
import 'package:doctor_app/pages/userprofile.dart';
import 'package:doctor_app/provider/doctoronhand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DOH()),
    ],
    child: MyApp(),
  ));
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
        "doctorprofile": (context) => DoctorProfileScreen(),
        "hospitalprofile": (context) => HospitalProfileScreen(),
        "userprofile": (context) => UserProfileScreen(),
        "changepassword": (context) => ChangePasswordScreen(),
      },
    );
  }
}
