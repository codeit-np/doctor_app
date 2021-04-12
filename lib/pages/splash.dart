import 'package:doctor_app/component/client_home.dart';
import 'package:doctor_app/pages/client/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkAuth() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    // preferences.remove('token');
    if (token != null) {
      Future.delayed(Duration(seconds: 3), () {
        //If Client redirect to client dashboard = 0
        //other wise redirect to Doctor dashboard = 2
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ClientDashboard()));
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.popAndPushNamed(context, 'intro');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ac_unit,
              size: 50,
            ),
            Text("Doctor on Hand")
          ],
        ),
      ),
    );
  }
}
