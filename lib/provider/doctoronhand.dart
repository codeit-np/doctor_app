import 'package:flutter/material.dart';

class DOH extends ChangeNotifier {
  int _doctorID;
  int _hospitalID;

//  For Doctors
  void setDoctorID(int data) {
    _doctorID = data;
    notifyListeners();
  }

  int get getDoctorID {
    return _doctorID;
  }

  //  For Hospital
  void setHospotalID(int data) {
    _hospitalID = data;
    notifyListeners();
  }

  int get getHospitalID {
    return _hospitalID;
  }
}
