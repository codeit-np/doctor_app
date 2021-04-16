import 'dart:convert';

import 'package:doctor_app/api/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget profile(context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          child: Icon(
            Icons.person_outline,
            size: 80,
          ),
        ),
        Card(
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'userprofile');
            },
            leading: Icon(Icons.person_outline),
            title: Text("My Account"),
            trailing: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'userprofile');
              },
              icon: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
        Card(
          child: ListTile(
            onTap: () {},
            leading: Icon(Icons.notifications_active),
            title: Text("Notification"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
        Card(
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'changepassword');
            },
            leading: Icon(Icons.lock),
            title: Text("Change Password"),
            trailing: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'changepassword');
              },
              icon: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
        Card(
          child: ListTile(
            onTap: () {},
            leading: Icon(Icons.help),
            title: Text("Help Center"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
        Card(
          child: ListTile(
            onTap: () async {
              Map data = {};
              var response = await Api().postData(data, 'logout');
              var result = json.decode(response.body);
              if (result['message'] == 'success') {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();

                preferences.remove('token');
                Navigator.popAndPushNamed(context, 'intro');
              }
            },
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios),
            ),
          ),
        )
      ],
    ),
  );
}
