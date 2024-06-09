import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/controller/current_location.dart';
import 'package:flutter_ecoclean/controller/dialogHelper.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapFavoritesPage extends StatefulWidget {
  const MapFavoritesPage({Key? key}) : super(key: key);

  @override
  State<MapFavoritesPage> createState() => _MapFavoritesPageState();
}

class _MapFavoritesPageState extends State<MapFavoritesPage> {
  late GoogleMapController mapController;
  LatLng selectedLocation = const LatLng(4.60971, -74.08175);
  String address = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getAddressFromLatLng(LatLng location) async {
    try {
      LocationData locationData = LocationData.fromMap({
        'latitude': location.latitude,
        'longitude': location.longitude,
      });

      String address = await CurrentLocation(locationData).getAddressFromCurrentLocation();

      if (mounted) {
        setState(() {
          this.address = address;
        });
      }
    } catch (e) {
      print('Error al obtener la dirección: $e');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      selectedLocation = position.target;
    });
    _getAddressFromLatLng(selectedLocation);
  }

  void _saveLocation() {
    print("Coordenadas guardadas: ${selectedLocation.latitude}, ${selectedLocation.longitude}");
    print("Dirección: $address");
    Navigator.pop(context);
    DialogHelper.location(context, address, (p0) => null);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text('Elegir Ubicación', style: TextStyle(color: Colors.green)),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: selectedLocation, zoom: 12),
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: true,
            onCameraMove: _onCameraMove,

          ),
          const Center(
            child: Icon(
              Icons.location_on_rounded,
              size: 40,
              color: Colors.green,
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: _saveLocation,
            child: Text(
              "Guardar Ubicación",
              style: TextStyle(fontSize: responsive.ip(5), color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
