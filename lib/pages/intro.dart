import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Doctor on Hand",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text("Welcome to doctor house"),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Icon(
                      Icons.ac_unit,
                      size: 100,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ElevatedButton(
                            child: Text("Login"),
                            onPressed: () {
                              Navigator.pushNamed(context, 'login');
                            }),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
