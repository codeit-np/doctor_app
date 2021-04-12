import 'dart:convert';

import 'package:doctor_app/api/api.dart';
import 'package:doctor_app/component/inputText.dart';
import 'package:doctor_app/const/const.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  int userType;
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
                        "Register Account",
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        "Please fill up the form to complete registration",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                        child: Form(
                      key: _key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Fullname
                          inputText(name, 'Full Name', Icons.person_add, false,
                              true, TextInputType.text),
                          // Fullname
                          inputText(mobile, 'Mobile', Icons.call, false, true,
                              TextInputType.phone),
                          // City

                          inputText(city, 'City', Icons.location_city, false,
                              true, TextInputType.text),
                          // Email
                          inputText(email, 'Email', Icons.email, false, true,
                              TextInputType.emailAddress),
                          // Password
                          inputText(password, 'Password', Icons.lock, true,
                              true, TextInputType.text),

                          // Row(
                          //   children: [
                          //     Container(
                          //       child: Row(
                          //         children: [
                          //           Text("Patient"),
                          //           Radio(
                          //               value: 0,
                          //               groupValue: userType,
                          //               onChanged: (value) {
                          //                 userType = value;
                          //                 print(value);
                          //                 setState(() {});
                          //               })
                          //         ],
                          //       ),
                          //     ),
                          //     Container(
                          //       child: Row(
                          //         children: [
                          //           Text("Doctor"),
                          //           Radio(
                          //               value: 2,
                          //               groupValue: userType,
                          //               onChanged: (value) {
                          //                 print(value);
                          //                 userType = value;
                          //                 setState(() {});
                          //               })
                          //         ],
                          //       ),
                          //     )
                          //   ],
                          // ),

                          Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (_key.currentState.validate()) {
                                          Map data = {
                                            "name": name.text,
                                            "email": email.text,
                                            "password": password.text,
                                            "user_type": "0",
                                          };

                                          var response = await Api()
                                              .loginAndRegister(
                                                  data, 'register');
                                          var result =
                                              json.decode(response.body);
                                          print(result);
                                          if (result['message'] == "success") {
                                            showDialog(
                                                context: context,
                                                builder: (builder) {
                                                  return AlertDialog(
                                                    title: Text("Message"),
                                                    content: Text(
                                                        "Registration Success"),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                'login');
                                                          },
                                                          child: Text("OK"))
                                                    ],
                                                  );
                                                });
                                          }
                                        }
                                      },
                                      child: Text("Register"))),
                            ],
                          )
                        ],
                      ),
                    )),
                  ),
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
