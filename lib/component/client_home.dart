import 'dart:convert';

import 'package:doctor_app/api/api.dart';
import 'package:doctor_app/const/const.dart';
import 'package:flutter/material.dart';

Widget clientHomeComponent(BuildContext context) {
  Future getData(String endPoint) async {
    var response = await Api().getData(endPoint);
    var data = json.decode(response.body)['data'];
    return data;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search",
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    IconButton(icon: Icon(Icons.messenger), onPressed: () {}),
                    IconButton(
                        icon: Icon(Icons.notifications), onPressed: () {}),
                  ],
                ),
              ),
            )
          ],
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
                      return Container(
                        width: 200,
                        child: Card(
                          elevation: .2,
                          child: Column(
                            children: [
                              Container(
                                width: 200,
                                height: 180,
                                child: Image.network(
                                  link + "uploadedFiles/" + mydata['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Text(mydata['name']),
                                    Text('Address: ' + mydata['name']),
                                    Text('Phone: ' +
                                        mydata['telephone'].toString()),
                                  ],
                                ),
                              )
                            ],
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
                      return Container(
                        width: 200,
                        child: Card(
                          elevation: .2,
                          child: Column(
                            children: [
                              Container(
                                width: 200,
                                height: 180,
                                child: Image.network(
                                  link + "uploadedFiles/" + mydata['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Text(mydata['name']),
                                    Text('Address: ' + mydata['name']),
                                    Text('Mobile: ' +
                                        mydata['mobile'].toString()),
                                  ],
                                ),
                              )
                            ],
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
