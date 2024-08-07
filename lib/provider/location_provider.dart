import 'package:flutter/material.dart';

class LocationData with ChangeNotifier {
  double? latitude;
  double? longitude;
  String? address;
  Map<String, dynamic>? addressData;

  void setLocationData(
      double lat, double long, String addr, Map<String, dynamic> addrData) {
    latitude = lat;
    longitude = long;
    address = addr;
    addressData = addrData;
    notifyListeners();
  }
}
