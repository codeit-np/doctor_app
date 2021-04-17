import 'package:doctor_app/component/client_home.dart';
import 'package:doctor_app/component/favourate.dart';
import 'package:doctor_app/component/profile.dart';
import 'package:doctor_app/component/search1.dart';
import 'package:flutter/material.dart';

class ClientDashboard extends StatefulWidget {
  @override
  _ClientDashboardState createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Doctor on Hand"),
          actions: [
            Row(
              children: [
                IconButton(icon: Icon(Icons.message), onPressed: () {}),
                IconButton(icon: Icon(Icons.notifications), onPressed: () {})
              ],
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favourate'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
        body: index == 0
            ? clientHomeComponent(context)
            : index == 1
                ? SearchScreen()
                : index == 2
                    ? Favourate()
                    : index == 3
                        ? profile(context)
                        : Text("Hello"),
      ),
    );
  }
}
