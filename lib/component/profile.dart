import 'package:flutter/material.dart';

Widget profile() {
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
            onTap: () {},
            leading: Icon(Icons.person_outline),
            title: Text("My Account"),
            trailing: IconButton(
              onPressed: () {},
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
            onTap: () {},
            leading: Icon(Icons.lock),
            title: Text("Change Password"),
            trailing: IconButton(
              onPressed: () {},
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
            onTap: () {},
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
