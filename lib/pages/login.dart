import 'dart:convert';

import 'package:doctor_app/api/api.dart';
import 'package:doctor_app/component/client_home.dart';
import 'package:doctor_app/component/inputText.dart';
import 'package:doctor_app/const/const.dart';
import 'package:doctor_app/pages/client/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text("Please login to continue"),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Email
                        inputText(email, 'Email', Icons.email, false, true,
                            TextInputType.emailAddress),
                        // Password
                        inputText(password, 'Password', Icons.lock, true, true,
                            TextInputType.text),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Checkbox(value: false, onChanged: (value) {}),
                                  Text("Remember")
                                ],
                              ),
                            ),
                            Container(
                              child: Text("Forget Password"),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (_key.currentState.validate()) {
                                        Map data = {
                                          "email": email.text,
                                          "password": password.text,
                                        };

                                        var response = await Api()
                                            .loginAndRegister(data, 'login');
                                        var result = json.decode(response.body);
                                        print(result['token']);
                                        if (result['message'] == "success") {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          preferences.setString('token',
                                              result['token'].toString());
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ClientDashboard()));
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (builder) {
                                                return AlertDialog(
                                                  title: Text("Message"),
                                                  content:
                                                      Text(result['message']),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("OK"))
                                                  ],
                                                );
                                              });
                                        }
                                      }
                                    },
                                    child: Text("Login"))),
                          ],
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'signup');
                            },
                            child: Text("Don't have an account? Sign Up"))
                      ],
                    ),
                  )),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "By creating an account, you accept our Terms & condition and agree to Privacy",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
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
