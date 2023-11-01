import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late Completer<GoogleMapController> mapController = Completer();
  LatLng initialPosition = LatLng(0, 0); // Coordenadas do IMD
  bool loadedMap = false;
  Future<void> trackLocation() async {
    LocationPermission locationPermission =
        await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double latitude = position.latitude;
    double longitude = position.longitude;

    setState(() {
      initialPosition = LatLng(latitude, longitude);
    });
    print(initialPosition);
  }

  @override
  void initState() {
    super.initState();
    trackLocation();
  }

  void onMapCompleted(GoogleMapController controller) {
    mapController.complete();
    loadedMap = true;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
            key: UniqueKey(),
            initialCameraPosition:
                CameraPosition(target: initialPosition, zoom: 15.0),
            myLocationButtonEnabled: true,
            onMapCreated: onMapCompleted);
  }
}
