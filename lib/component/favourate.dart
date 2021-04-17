import 'dart:convert';

import 'package:doctor_app/api/api.dart';
import 'package:doctor_app/const/const.dart';
import 'package:doctor_app/provider/doctoronhand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourate extends StatefulWidget {
  @override
  _FavourateState createState() => _FavourateState();
}

class _FavourateState extends State<Favourate> {
  Future getData() async {
    var response = await Api().getData('favourates');
    var data = json.decode(response.body)['data'];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    DOH provider = Provider.of<DOH>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                default:
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var mydata = snapshot.data[index];
                      return Card(
                        child: ListTile(
                          onTap: () {
                            provider.setDoctorID(mydata['id']);
                            Navigator.pushNamed(context, 'doctorprofile');
                          },
                          leading: Container(
                            width: 100,
                            height: 100,
                            child: Image.network(link + mydata['image']),
                          ),
                          title: Text(mydata['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Address: " + mydata['city']),
                              Text("Ward: " + mydata['ward'].toString()),
                              Text("Mobile: " + mydata['mobile'].toString()),
                            ],
                          ),
                        ),
                      );
                    },
                  );
              }
            },
          )
        ],
      ),
    );
  }
}
