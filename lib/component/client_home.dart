import 'dart:convert';

import 'package:doctor_app/api/api.dart';
import 'package:doctor_app/const/const.dart';
import 'package:doctor_app/provider/doctoronhand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget clientHomeComponent(BuildContext context) {
  DOH provider = Provider.of<DOH>(context);
  Future getData(String endPoint) async {
    var response = await Api().getData(endPoint);
    var data = json.decode(response.body);
    return data;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    child: Column(
      children: [
        ListTile(
          title: Text("Doctors"),
          subtitle: Text("Checkout our lates doctors"),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 250,
          child: FutureBuilder(
            future: getData('doctors'),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var mydata = snapshot.data[index];
                      return GestureDetector(
                        onTap: () {
                          provider.setDoctorID(mydata['id']);
                          Navigator.pushNamed(context, 'doctorprofile');
                        },
                        child: Container(
                          width: 200,
                          child: Card(
                            elevation: .2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 200,
                                  height: 180,
                                  child: Image.network(
                                    link + mydata['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(mydata['name']),
                                      Text(
                                        'Address: ' + mydata['city'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Phone: ' +
                                            mydata['telephone'].toString(),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
              }
            },
          ),
        ),

        // Hospital List
        ListTile(
          title: Text("Hospitals"),
          subtitle: Text("Checkout our lates hospitals"),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 250,
          child: FutureBuilder(
            future: getData('hospitals'),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var mydata = snapshot.data[index];
                      return GestureDetector(
                        onTap: () {
                          provider.setHospotalID(mydata['id']);
                          Navigator.pushNamed(context, 'hospitalprofile');
                        },
                        child: Container(
                          width: 200,
                          child: Card(
                            elevation: .2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 200,
                                  height: 180,
                                  child: Image.network(
                                    link + mydata['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(mydata['name']),
                                      Text(
                                        'Address: ' + mydata['city'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        'Mobile: ' +
                                            mydata['mobile'].toString(),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
              }
            },
          ),
        ),
      ],
    ),
  );
}
