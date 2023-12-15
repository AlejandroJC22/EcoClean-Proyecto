import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/controller/dialogHelper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:math';

class MapLocation extends StatefulWidget {
  final String userLocation;
  final String locationType;

  const MapLocation({Key? key, required this.userLocation, required this.locationType}) : super(key: key);

  @override
  _MapLocationState createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de la ubicación'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
          _updateMap();
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(4.60971, -74.08175),
          zoom: 15.0,
        ),
        markers: markers,
      ),
    );
  }

  void _updateMap() async {
    try {
      // Obtiene la ubicación almacenada en la base de datos
      List<Location> locations = await locationFromAddress(widget.userLocation);

      if (locations.isNotEmpty) {
        Location location = locations.first;
        double latitude = location.latitude;
        double longitude = location.longitude;

        // Añade el marcador para la ubicación almacenada en la base de datos
        markers.add(
          Marker(
            markerId: MarkerId('userLocation'),
            position: LatLng(latitude, longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(
              title: 'Ubicación de ${_getLocationTypeTitle(widget.locationType)}',
            ),
          ),
        );

        mapController.animateCamera(CameraUpdate.newLatLng(LatLng(latitude, longitude)));

        // Añade los puntos aleatorios
        setState(() {
          markers.addAll(_generateRandomMarkers(LatLng(latitude, longitude)));
        });
      } else {
        // Muestra un diálogo de alerta si no se encuentran datos de ubicación
        DialogHelper.showAlertDialog(context, "No hay datos", "Por favor establezca una dirección en Rutas Favoritas");
      }
    } catch (e) {
      // Manejo de errores al obtener coordenadas
      print('Error al obtener coordenadas: $e');
    }
  }

  // Función auxiliar para obtener el título adecuado según la etiqueta
  String _getLocationTypeTitle(String locationType) {
    if (locationType == 'work') {
      return 'Trabajo';
    } else if (locationType == 'home') {
      return 'Casa';
    } else {
      return 'Desconocido'; // Puedes ajustar según tus necesidades
    }
  }

  Set<Marker> _generateRandomMarkers(LatLng center) {
    List<String> collectionPointNames = [
      'Punto de recolección de Vidrio',
      'Punto de recolección de Residuos Organicos',
      'Punto de recolección de Papel',
      'Punto de recolección de Plástico',
      'Punto de recolección de Residuos Textiles',
      'Punto de recolección de Pilas y Baterías',
      'Punto de recolección de Electrónicos y Equipos Informáticos',
    ];

    int numberOfPoints = 4 + Random().nextInt(4);

    List<String> selectedNames = collectionPointNames.take(numberOfPoints).toList();

    List<Marker> generatedMarkers = [];

    double maxRadius = 0.01;

    BitmapDescriptor customIcon1 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    BitmapDescriptor customIcon2 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    BitmapDescriptor customIcon3 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
    BitmapDescriptor customIcon4 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
    BitmapDescriptor customIcon5 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    BitmapDescriptor customIcon6 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
    BitmapDescriptor customIcon7 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);

    List<BitmapDescriptor> customIcons = [customIcon1, customIcon2, customIcon3, customIcon4, customIcon5, customIcon6, customIcon7];

    for (int i = 0; i < numberOfPoints; i++) {
      double angle = Random().nextDouble() * 2 * pi;
      double distance = Random().nextDouble() * maxRadius;
      LatLng randomPosition = LatLng(
        center.latitude + distance * cos(angle),
        center.longitude + distance * sin(angle),
      );

      print('LatLng $i: $randomPosition');

      generatedMarkers.add(
        Marker(
          markerId: MarkerId('randomMarker$i'),
          position: randomPosition,
          icon: customIcons[i % customIcons.length],
          infoWindow: InfoWindow(title: selectedNames[i]),
        ),
      );
    }

    return Set.from(generatedMarkers);
  }
}
