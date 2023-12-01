import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late Completer<GoogleMapController> mapController = Completer();
  LatLng initialPosition = LatLng(0, 0); // Default coordinates
  bool loadedMap = false;
  Set<Marker> _markers = {};

  Future<void> trackLocation() async {
    LocationPermission locationPermission =
        await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double latitude = position.latitude;
    double longitude = position.longitude;

    setState(() {
      initialPosition = LatLng(latitude, longitude);
      _markers.add(
        Marker(
          markerId: MarkerId("userLocation"),
          position: initialPosition,
        ),
      );
    });

    if (loadedMap) {
      final GoogleMapController controller = await mapController.future;
      controller.animateCamera(CameraUpdate.newLatLng(initialPosition));
    }
  }

  @override
  void initState() {
    super.initState();
    trackLocation();
  }

  void onMapCompleted(GoogleMapController controller) {
    mapController.complete(controller);
    loadedMap = true;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      key: UniqueKey(),
      initialCameraPosition: CameraPosition(target: initialPosition, zoom: 15.0),
      myLocationButtonEnabled: true,
      markers: _markers,
      onMapCreated: onMapCompleted,
    );
  }
}
