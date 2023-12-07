import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapGoogle {

  final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(4.60971, -74.08175),
    zoom: 4,
  );

  GoogleMap buildGoogleMap() {
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
    );
  }
}