import 'dart:convert';

import 'package:doctor_app/api/api.dart';
import 'package:doctor_app/const/const.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future search(Map data) async {
    var response = await Api().postData(data, 'search');
    var result = json.decode(response.body)['data'];
    return result;
  }

  String keyword = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      keyword = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                keyword = value;
                setState(() {});
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search Specialist'),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: search({"specialist": keyword}),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data[0]['doctors'].length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                link +
                                    "uploadedFiles/" +
                                    snapshot.data[0]['doctors'][index]['image']
                                        .toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[0]['doctors'][index]['name'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Mobile" +
                                        snapshot.data[0]['doctors'][index]
                                                ['mobile']
                                            .toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "Specialist" +
                                        snapshot.data[0]['doctors'][index]
                                                ['specialist']
                                            .toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "City: " +
                                        snapshot.data[0]['doctors'][index]
                                                ['city']
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("Error");
                } else {
                  return Text("loading");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
