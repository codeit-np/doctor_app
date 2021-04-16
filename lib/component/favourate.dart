import 'dart:convert';

import 'package:doctor_app/api/api.dart';
import 'package:flutter/material.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }
}
