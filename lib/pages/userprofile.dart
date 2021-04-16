import 'dart:convert';

import 'package:doctor_app/api/api.dart';
import 'package:doctor_app/component/inputText.dart';
import 'package:doctor_app/const/const.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  Future getProfile() async {
    var response = await Api().getData('user');
    var data = json.decode(response.body);
    name.text = data['name'];
    email.text = data['email'];
    city.text = data['city'];
    mobile.text = data['mobile'];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getProfile(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  default:
                    return Form(
                      key: _key,
                      child: Column(
                        children: [
                          inputText(name, 'Full Name', Icons.person_outline,
                              false, true, TextInputType.text),
                          inputText(email, 'Email', Icons.person_outline, false,
                              true, TextInputType.emailAddress),
                          inputText(mobile, 'Mobile', Icons.call, false, false,
                              TextInputType.phone),
                          inputText(city, 'Address', Icons.location_city, false,
                              false, TextInputType.text),
                          ElevatedButton(
                              onPressed: () async {
                                if (_key.currentState.validate()) {
                                  Map data = {
                                    "name": name.text,
                                    "email": email.text,
                                    "mobile": mobile.text,
                                    "city": city.text,
                                  };

                                  var response =
                                      await Api().postData(data, 'update');
                                  var result = json.decode(response.body);
                                  print(result);
                                  if (result['message'] == 'success') {
                                    showDialog(
                                        context: context,
                                        builder: (builder) {
                                          return AlertDialog(
                                            title: Text("Message"),
                                            content: Text("Record updated"),
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
                    );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
