import 'package:flutter/material.dart';

class SaveAddressViewModel extends ChangeNotifier {
  String pincode = '';
  String houseNumber = '';
  String roadName = '';
  String name = '';
  String phoneNumber = '';
  bool useAsPrimary = false;

  void updatePincode(String value) {
    pincode = value;
    notifyListeners();
  }

  void updateHouseNumber(String value) {
    houseNumber = value;
    notifyListeners();
  }

  void updateRoadName(String value) {
    roadName = value;
    notifyListeners();
  }

  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updatePhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void toggleUseAsPrimary(bool value) {
    useAsPrimary = value;
    notifyListeners();
  }
} 