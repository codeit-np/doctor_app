import 'dart:convert';

import 'package:doctor_app/api/api.dart';
import 'package:doctor_app/component/inputText.dart';
import 'package:doctor_app/const/const.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _key,
              child: Column(
                children: [
                  inputText(password, 'New Password', Icons.person_outline,
                      true, true, TextInputType.text),
                  ElevatedButton(
                      onPressed: () async {
                        if (_key.currentState.validate()) {
                          Map data = {
                            "password": name.text,
                          };

                          var response =
                              await Api().postData(data, 'changepassword');
                          var result = json.decode(response.body);
                          print(result);
                          if (result['message'] == 'success') {
                            showDialog(
                                context: context,
                                builder: (builder) {
                                  return AlertDialog(
                                    title: Text("Message"),
                                    content: Text("Password Changed"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("OK"))
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      child: Text("Update"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
