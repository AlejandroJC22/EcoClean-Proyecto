import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


//Clase constructora mapa página principal
class GoogleMapWidget extends StatefulWidget {
  //Variable para almacenar la ubicación del usuario
  final LocationData? userLocation;

  //Traer la ubicación del usuario de la vista home
  GoogleMapWidget({required this.userLocation});

  @override
  //Iniciar el mapa en la pantalla home
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

//Clase ilustración de mapa
class _GoogleMapWidgetState extends State<GoogleMapWidget> {

  //Controlador del mapa
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    //Retornar el mapa con las siguientes caracteristicas
    return MapGoogle(
      //Mostrar la ubicación del usuario
      userLocation: widget.userLocation,
      //Parametros de creación de mapa
      onMapCreated: onMapCreated,
    );
  }

  // Callback llamado cuando se crea el mapa. Inicializa el controlador del mapa y anima la cámara a la ubicación del usuario.
  void onMapCreated(GoogleMapController controller) {
    //Traer el controlador del mapa
    mapController = controller;

    // Animar la cámara desde la posición inicial hasta la ubicación del usuario
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(widget.userLocation!.latitude!, widget.userLocation!.longitude!),
        16.0,
      ),
    );
  }
}

//Clase contenedora logica
// ignore: must_be_immutable
class MapGoogle extends StatelessWidget {
  //Variable para almacenar la ubicación del usuario
  final LocationData? userLocation;
  //Definir las animaciones de la camara
  final Function(GoogleMapController) onMapCreated;
  //Definir un nuevo controlador para mostrar puntos de recolección
  late GoogleMapController mapController;

  //Traer las animaciones de camara y la ubicación del usuario
  MapGoogle({required this.userLocation, required this.onMapCreated});

  @override
  //Construcción del mapa
  Widget build(BuildContext context) {
    //Si el usuario no permite el acceso a la ubicación
    return userLocation == null
        ? const Stack(
      children: [
        //mostrar mapa con las coordenadas de la ciudad
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(4.60971, -74.08175),
            zoom: 10,
          ),
        ),
        //Mostrar animación de carga
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    )
    //Si permite los permisos de ubicación
        : GoogleMap(
      //Boton para centrar el mapa en la ubicación del usuario
      myLocationButtonEnabled: true,
      //Mostrar la ubicación del usuario en el mapa
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      //Posicionar el mapa en la ubicación del usuario
      initialCameraPosition: CameraPosition(
        target: LatLng(userLocation!.latitude!, userLocation!.longitude!),
        zoom: 14,
      ),
      //Mostrar puntos generados en el mapa
      markers: Set.from(generateRandomMarkers(
        LatLng(userLocation!.latitude!, userLocation!.longitude!),
      )),
      //Nuevas animaciones de camara
      onMapCreated: (controller) {
        onMapCreated(controller);

        // Llamar a la función para mostrar todos los marcadores después de un breve retraso
        Future.delayed(const Duration(milliseconds: 500), () {
          showAllMarkers(controller);
        });
      },
      onTap: (LatLng latLng) {
        // Mover la cámara hacia el marcador seleccionado cuando se hace clic en el mapa
        onMapCreated(mapController); // Llamar a onMapCreated para actualizar el controlador
        //Mostrar las nuevas animaciones de camara
        mapController.animateCamera(CameraUpdate.newLatLng(latLng));
            },
    );
  }

  void showAllMarkers(GoogleMapController controller) {
    // Obtener todos los marcadores
    Set<Marker> allMarkers = Set.from(generateRandomMarkers(
      LatLng(userLocation!.latitude!, userLocation!.longitude!),
    ));

    // Calcular los límites (bounds) para todos los marcadores
    LatLngBounds bounds = getBounds(allMarkers);

    // Animar la cámara para mostrar todos los marcadores en la pantalla
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
  }

  // Método para calcular los límites (bounds) que rodean todos los marcadores
  LatLngBounds getBounds(Set<Marker> markers) {
    // Inicializar variables con valores extremos para asegurar que se actualicen correctamente
    double minLat = double.infinity;        // Latitud mínima inicializada al infinito
    double minLng = double.infinity;        // Longitud mínima inicializada al infinito
    double maxLat = double.negativeInfinity; // Latitud máxima inicializada a negativo infinito
    double maxLng = double.negativeInfinity; // Longitud máxima inicializada a negativo infinito

    // Iterar a través de cada marcador para encontrar los límites
    for (Marker marker in markers) {
      double lat = marker.position.latitude;  // Obtener la latitud del marcador
      double lng = marker.position.longitude; // Obtener la longitud del marcador

      // Actualizar las coordenadas mínimas y máximas según la latitud y longitud del marcador actual
      minLat = min(minLat, lat);
      minLng = min(minLng, lng);
      maxLat = max(maxLat, lat);
      maxLng = max(maxLng, lng);
    }

    // Crear y devolver un objeto LatLngBounds que representa los límites calculados
    return LatLngBounds(
      southwest: LatLng(minLat, minLng), // Esquina suroeste de los límites
      northeast: LatLng(maxLat, maxLng), // Esquina noreste de los límites
    );
  }

  // Generar marcadores aleatorios alrededor de una posición central.
  List<Marker> generateRandomMarkers(LatLng center) {
    // Nombres de los puntos de recolección posibles
    List<String> collectionPointNames = [
      'Punto de recolección de Vidrio',
      'Punto de recolección de Residuos Organicos',
      'Punto de recolección de Papel',
      'Punto de recolección de Plástico',
      'Punto de recolección de Residuos Textiles',
      'Punto de recolección de Pilas y Baterías',
      'Punto de recolección de Electrónicos y Equipos Informáticos',
    ];

    // Determinar el número de puntos de recolección aleatorios a generar
    int numberOfPoints = 4 + Random().nextInt(4);

    // Seleccionar nombres aleatorios de puntos de recolección
    List<String> selectedNames = collectionPointNames.take(numberOfPoints).toList();

    // Lista para almacenar los marcadores generados
    List<Marker> markers = [];

    // Radio máximo para dispersar los puntos de recolección
    double maxRadius = 0.01;

    // Colores personalizados para diferentes tipos de puntos de recolección
    BitmapDescriptor customIcon1 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    BitmapDescriptor customIcon2 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    BitmapDescriptor customIcon3 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    BitmapDescriptor customIcon4 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
    BitmapDescriptor customIcon5 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    BitmapDescriptor customIcon6 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose);
    BitmapDescriptor customIcon7 = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);

    List<BitmapDescriptor> customIcons = [customIcon1, customIcon2, customIcon3, customIcon4, customIcon5, customIcon6, customIcon7];

    // Generar marcadores aleatorios
    for (int i = 0; i < numberOfPoints; i++) {
      // Calcular posición aleatoria alrededor del centro
      double angle = Random().nextDouble() * 2 * pi;
      double distance = Random().nextDouble() * maxRadius;
      LatLng randomPosition = LatLng(
        center.latitude + distance * cos(angle),
        center.longitude + distance * sin(angle),
      );

      // Imprimir la posición generada (esto puede ser eliminado en la versión final)
      print('LatLng $i: $randomPosition');

      // Crear un marcador con la posición, icono personalizado y nombre del punto de recolección
      Marker randomMarker = Marker(
        markerId: MarkerId('randomMarker$i'),
        position: randomPosition,
        icon: customIcons[i % customIcons.length], // Asignar un icono personalizado
        infoWindow: InfoWindow(title: selectedNames[i]),
      );

      // Agregar el marcador a la lista de marcadores
      markers.add(randomMarker);
    }

    // Devolver la lista de marcadores generados
    return markers;
  }
}
