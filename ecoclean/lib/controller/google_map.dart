import 'package:google_maps_flutter/google_maps_flutter.dart';

//Clase constructora del mapa
class MapGoogle {
  //Posición inicial del mapa
  final CameraPosition initialCameraPosition = const CameraPosition(
    //Ubicación inicla
    target: LatLng(4.60971, -74.08175),
    //Zoom del mapa
    zoom: 16,
  );
  //Mostrar ubicación del usuario en el mapa
  GoogleMap buildGoogleMap(LatLng userLocation) {
    //Constructor del mapa
    return GoogleMap(
      //Posición del mapa según ubicación
      initialCameraPosition: CameraPosition(
        //Posición del usuario
        target: userLocation,
        zoom: 16,
      ),
      //Mostrar icono de ubicación en el mapa
      markers: {
        Marker(
          markerId: MarkerId('userLocation'),
          position: userLocation,
          //información al pulsar el icono
          infoWindow: InfoWindow(title: 'Tu ubicación'),
        ),
      },
    );
  }
}
