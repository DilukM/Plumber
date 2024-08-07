import 'package:flutter/material.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import 'package:plumber/provider/location_provider.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Future<void> handleLocationPicked(pickedData) async {
    final locationProvider = Provider.of<LocationData>(context, listen: false);
    locationProvider.setLocationData(
      pickedData.latLong.latitude,
      pickedData.latLong.longitude,
      pickedData.address,
      pickedData.addressData,
    );

    await Future.delayed(
        Duration(milliseconds: 200)); // Simulate processing delay

    Navigator.pop(context, pickedData.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLocationPicker(
        initZoom: 11,
        minZoomLevel: 5,
        maxZoomLevel: 16,
        trackMyPosition: true,
        selectLocationButtonHeight: 50,
        searchBarBackgroundColor: Colors.white,
        selectedLocationButtonTextstyle: const TextStyle(fontSize: 14),
        mapLanguage: 'en',
        onError: (e) => print(e),
        onPicked: (pickedData) async {
          await handleLocationPicked(pickedData);
        },
        onChanged: (pickedData) {
          print(pickedData.latLong.latitude);
          print(pickedData.latLong.longitude);
          print(pickedData.address);
          print(pickedData.addressData);
        },
        showContributorBadgeForOSM: true,
      ),
    );
  }
}
