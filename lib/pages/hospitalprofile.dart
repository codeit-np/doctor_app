import 'dart:convert';

import 'package:doctor_app/api/api.dart';
import 'package:doctor_app/const/const.dart';
import 'package:doctor_app/provider/doctoronhand.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';

class HospitalProfileScreen extends StatefulWidget {
  @override
  _HospitalProfileScreenState createState() => _HospitalProfileScreenState();
}

class _HospitalProfileScreenState extends State<HospitalProfileScreen> {
  Future getProfile(int id) async {
    var response = await Api().getData('hospitals/$id');
    var data = json.decode(response.body);
    return data;
  }

  Future getNearestHospital(int id) async {
    var response = await Api().getData('nearest/$id');
    var data = json.decode(response.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    DOH provider = Provider.of<DOH>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Hospital Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getProfile(provider.getHospitalID),
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
                          trailing: IconButton(
                              icon: Icon(Icons.favorite_outline),
                              onPressed: () {}),
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
                        ),
                        ListTile(
                          title: Text("Hospital Lication"),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          child: FlutterMap(
                            options: MapOptions(
                              center: LatLng(double.parse(snapshot.data['lat']),
                                  double.parse(snapshot.data['lon'])),
                              zoom: 13.0,
                            ),
                            layers: [
                              TileLayerOptions(
                                  urlTemplate:
                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: ['a', 'b', 'c']),
                              MarkerLayerOptions(
                                markers: [
                                  Marker(
                                    width: 24.0,
                                    height: 24.0,
                                    point: LatLng(
                                        double.parse(snapshot.data['lat']),
                                        double.parse(snapshot.data['lon'])),
                                    builder: (ctx) => Container(
                                      child: Icon(Icons.place),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                }
              },
            ),
            ListTile(
              title: Text("Nearest Hospitals"),
              subtitle: Text("Nearest Hospital within 16km"),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: FutureBuilder(
                future: getNearestHospital(provider.getHospitalID),
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
      ),
    );
  }
}
