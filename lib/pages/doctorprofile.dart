import 'dart:convert';

import 'package:doctor_app/api/api.dart';
import 'package:doctor_app/const/const.dart';
import 'package:doctor_app/provider/doctoronhand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorProfileScreen extends StatefulWidget {
  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  Future getProfile(int id) async {
    var response = await Api().getData('doctors/$id');
    var data = json.decode(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    DOH provider = Provider.of<DOH>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getProfile(provider.getDoctorID),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  default:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Image.network(link + snapshot.data['image']),
                        ),
                        ListTile(
                          trailing: ElevatedButton(
                            onPressed: () async {
                              Map data = {"doctor_id": snapshot.data['id']};
                              var response =
                                  await Api().postData(data, 'favourates');
                              var result = json.decode(response.body);
                              print(result);
                            },
                            child: Text("Add to favourate"),
                          ),
                          title: Text(snapshot.data['name']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Address: " +
                                  snapshot.data['city'].toString() +
                                  " | " +
                                  "Ward: " +
                                  snapshot.data['ward'].toString()),
                              Text("Address: " +
                                  snapshot.data['city'].toString() +
                                  " | " +
                                  "Ward: " +
                                  snapshot.data['ward'].toString())
                            ],
                          ),
                        )
                      ],
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
