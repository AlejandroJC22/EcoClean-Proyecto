import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/views/chatBotAi.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/google_map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Variable para almacenar el nombre de usuario
  String username = "";
  // Variable para almacenar la ubicación del usuario
  LocationData? currentLocation;

  //Inicializar los procesos
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  //Cargar los datos de la base de datos
  Future<void> _loadUserInfo() async {
    //Obtener los datos del usuario autenticado
    final User? user = FirebaseAuth.instance.currentUser;

    //Si el usuario existe, obtener los datos de la base de datos
    if (user != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      //Buscar el nombre y mostrarlo en pantalla
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;

        // Verificar que las propiedades existen y no son nulas antes de acceder a ellas
        if (userData['nombre'] != null) {
          setState(() {
            //Variable que almacena el nombre
            username = userData['nombre'];
          });
        }
        //Si no encuentra datos mostrar error
      } else {
        print('No se encontraron datos del usuario en Firestore');
      }
      //Si no se puede conectar a la base de datos, mostrar error
    } else {
      print('No se pudo obtener el usuario actual');
    }

    // Obtener la ubicación del usuario
    final Location location = Location();
    //Esperamos que el usuario nos de acceso a su ubicación
    try {
      final LocationData locationData = await location.getLocation();
      setState(() {
        //Almacenar la ubicación
        currentLocation = locationData;
      });
      //Si no da permiso mostrar error
    } catch (e) {
      print("Error obtaining location: $e");
    }
  }

  //Construir la vista
  @override
  Widget build(BuildContext context) {
    //Asignar tamaño dependiendo la diagonal obtenida
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      //Retornar una lista
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              //Titulo inicial con el nombre del usuario
              Container(
                alignment: Alignment.bottomLeft,
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  "Bienvenido $username",
                  style: TextStyles.tituloNegro(responsive),
                ),
              ),
              //Espaciado entre campos
              const SizedBox(
                height: 30,
              ),
              //Subtitulo del contenido
              Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 15),
                  child: Text(
                    "Rutas cerca de ti",
                    style: TextStyles.subtitulos(responsive),
                  )
              ),
              //Espaciado entre campos
              const SizedBox(
                height: 10,
              ),
              //Mostrar mapa con la ubicación del usuario
              SizedBox(
                child: Container(
                  //Tamaño y posición del mapa
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  height: 300,
                  //Si se permite la ubicación mostrarla en el mapa
                  child: currentLocation != null
                      ? MapGoogle().buildGoogleMap(
                    LatLng(
                      //Posición en coordenadas del usuario, logica del mapa en google_map.dart
                      currentLocation!.latitude!,
                      currentLocation!.longitude!,
                    ),
                  )
                  //Mientras se accede a la ubicación, mostrar simbolo de carga
                      : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Circulo de carga
                      CircularProgressIndicator(),
                      //tamaño del circulo
                      SizedBox(height: 10),
                      //texto guia
                      Text(
                        'Calculando ruta...',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              //Espaciado entre campos
              const SizedBox(
                height: 15,
              ),
              //Subtitulo guia
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 15),
                child: Text(
                  "Empresas prestadoras del servicio",
                  style: TextStyles.subtitulos(responsive),
                ),
              ),
              //Espaciado entre campos
              const SizedBox(
                height: 10,
              ),
              //Espacio para visualizar empresas prestadoras del servicio
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  //Tamaño del espacio
                  width: double.infinity,
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      //Información de cada empresa junto a link de acceso
                      buildCards('lib/iconos/bogota_limpia.png',
                          'https://www.bogotalimpia.com/'),
                      SizedBox(width: 15),
                      buildCards('lib/iconos/ciudad_limpia.jpg',
                          'https://www.ciudadlimpia.com.co/'),
                      SizedBox(width: 15),
                      buildCards('lib/iconos/lime.jpeg',
                          'https://www.lime.net.co/'),
                      SizedBox(width: 15),
                      buildCards('lib/iconos/area_limpia.png',
                          'https://arealimpia.com.co/'),
                      SizedBox(width: 15),
                      buildCards('lib/iconos/promoambiental.png',
                          'https://www.promoambientaldistrito.com/'),
                    ],
                  ),
                )
              ),
              //Espaciado entre campos
              const SizedBox(
                height: 20,
              ),
              //Subtitulo guia
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
                //Boton ChatBot
                trailing: InkWell(
                  onTap: () {
                    //Dirigir a la pantalla del chatbot
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChatBotPage(),
                    ));
                  },
                  //Diseño del boton
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    //Alineación del icono del boton
                    child: const Center(
                      child: Icon(
                        Icons.chat_bubble,
                        color: Colors.white,
                        size: 30, // Color del icono
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

  //Diseño de la lista horizontal imagenes de empresas prestadoras del servicio
  Widget buildCards(String imagePath, String url) {
    //Acceso a internet
    final uri = Uri.parse(url);
    return Container(
      //Alineación y tamaño
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      height: 100,
      //Diseño columna
      child: Column(
        children: [
          Expanded(
            //Diseño circular en los bordes
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                //Abrir navegador al pulsar sobre la imagen
                child: InkWell(
                  onTap: ()  async {
                    if (await canLaunchUrl(uri)){
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
