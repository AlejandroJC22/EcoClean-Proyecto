// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/controller/google_map.dart';
import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/views/chatBot.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

// Clase principal que representa la pantalla principal de la aplicación.
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

// Estado de la pantalla principal.
class _HomeState extends State<Home> {
  // Variable para almacenar el nombre de usuario.
  String username = "";

  // Variable para almacenar la ubicación actual del usuario.
  LocationData? currentLocation;

  // Método que se llama al inicializar el estado de la pantalla.
  @override
  void initState() {
    super.initState();
    // Inicializar la carga de la información del usuario.
    _loadUserInfo();
  }


  // Método asincrónico para cargar la información del usuario.
  Future<void> _loadUserInfo() async {
    // Obtener el usuario actualmente autenticado.
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Obtener el documento del usuario desde Firestore.
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Verificar si existe el documento del usuario en Firestore.
      if (userDoc.exists) {
        // Obtener los datos del usuario como un mapa.
        final userData = userDoc.data() as Map<String, dynamic>;

        // Verificar si el campo 'nombre' existe en los datos del usuario.
        if (userData['nombre'] != null) {
          // Actualizar el estado con el nombre del usuario.
          setState(() {
            username = userData['nombre'];
          });
        }
      } else {
        // Imprimir mensaje si no se encuentra el documento del usuario en Firestore.
        print('No se encontraron datos del usuario en Firestore');
      }
    } else {
      // Imprimir mensaje si no se puede obtener el usuario actual.
      print('No se pudo obtener el usuario actual');
    }

    // Inicializar la instancia de Location.
    final Location location = Location();
    try {
      // Obtener la ubicación actual del usuario.
      final LocationData locationData = await location.getLocation();
      // Actualizar el estado con la ubicación actual.
      setState(() {
        currentLocation = locationData;
      });
    } catch (e) {
      // Imprimir mensaje si hay un error al obtener la ubicación.
      print("Error obtaining location: $e");
    }
  }


  // Método para construir la interfaz de la pantalla principal.
  @override
  Widget build(BuildContext context) {
    // Instancia de la clase Responsive para gestionar la responsividad del diseño.
    final Responsive responsive = Responsive.of(context);

    // Estructura principal del widget.
    return Scaffold(
      // Contenedor principal que abarca toda la pantalla.
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Espaciado superior
              const SizedBox(
                height: 20,
              ),
              // Contenedor para mostrar el saludo al usuario
              Container(
                alignment: Alignment.bottomLeft,
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  "Bienvenido $username",
                  style: TextStyles.tituloNegro(responsive),
                ),
              ),
              // Espaciado adicional
              const SizedBox(
                height: 30,
              ),
              // Título para las rutas cercanas
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 15),
                child: Text(
                  "Rutas cerca de ti",
                  style: TextStyles.subtitulos(responsive),
                ),
              ),
              // Espaciado adicional
              const SizedBox(
                height: 10,
              ),
              // Contenedor para mostrar el mapa con las rutas
              SizedBox(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  height: 300,
                  child: GoogleMapWidget(userLocation: currentLocation),
                ),
              ),
              // Espaciado adicional
              const SizedBox(
                height: 15,
              ),
              // Título para las empresas prestadoras del servicio
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 15),
                child: Text(
                  "Empresas prestadoras del servicio",
                  style: TextStyles.subtitulos(responsive),
                ),
              ),
              // Espaciado adicional
              const SizedBox(
                height: 10,
              ),
              // Tarjeta deslizable con enlaces a empresas prestadoras del servicio
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      buildCards(
                          'lib/iconos/bogota_limpia.png',
                          'https://www.bogotalimpia.com/'),
                      SizedBox(width: 15),
                      buildCards(
                          'lib/iconos/ciudad_limpia.jpg',
                          'https://www.ciudadlimpia.com.co/'),
                      SizedBox(width: 15),
                      buildCards(
                          'lib/iconos/lime.jpeg', 'https://www.lime.net.co/'),
                      SizedBox(width: 15),
                      buildCards(
                          'lib/iconos/area_limpia.png',
                          'https://arealimpia.com.co/'),
                      SizedBox(width: 15),
                      buildCards(
                          'lib/iconos/promoambiental.png',
                          'https://www.promoambientaldistrito.com/'),
                    ],
                  ),
                ),
              ),
              // Espaciado adicional
              const SizedBox(
                height: 20,
              ),
              // Elemento de lista con enlace al ChatBot
              ListTile(
                title: Text(
                  '¿Tienes dudas?',
                  style: TextStyles.preguntas(responsive),
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  'Pregúntale a nuestro ChatBot',
                  style: TextStyles.enlaces(responsive),
                  textAlign: TextAlign.center,
                ),
                trailing: InkWell(
                  onTap: () {
                    // Navegar a la página del ChatBot al hacer clic en el ícono de burbuja de chat.
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatBotPage(),
                    ));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.chat_bubble,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir tarjetas deslizables con imágenes y enlaces a empresas prestadoras de servicio.
  Widget buildCards(String imagePath, String url) {
    // Crear instancia de Uri a partir de la cadena de URL proporcionada.
    final uri = Uri.parse(url);

    // Retornar un contenedor con la tarjeta deslizable.
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      height: 100,
      child: Column(
        children: [
          // Widget expandido para ajustar la relación de aspecto de la imagen.
          Expanded(
            child: AspectRatio(
              aspectRatio: 4 / 3,
              // Recortar y redondear las esquinas de la imagen.
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  // Configurar acción al hacer clic en la imagen.
                  onTap: () async {
                    // Verificar si se puede lanzar la URL y abrir el enlace.
                    if (await canLaunchUrl(uri)) {
                      launchUrl(uri);
                    }
                  },
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}