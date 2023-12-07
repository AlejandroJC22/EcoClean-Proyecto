import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/google_map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username = ""; // Variable para almacenar el nombre de usuario

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print('Usuario actual: ${user
          .uid}'); // Agrega una impresión para verificar el usuario actual
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;

        print(
            'Datos del usuario cargados: $userData'); // Agrega una impresión para los datos del usuario

        // Verificar que las propiedades existen y no son nulas antes de acceder a ellas
        if (userData['nombre'] != null) {
          setState(() {
            username = userData['nombre'];
          });
        }
      } else {
        print('No se encontraron datos del usuario en Firestore');
      }
    } else {
      print('No se pudo obtener el usuario actual');
    }
  }


  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  "Bienvenido $username",
                  style: TextStyles.tituloNegro(responsive),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 15),
                  child: Text(
                    "Rutas cerca de ti",
                    style: TextStyles.subtitulos(responsive),
                  )
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Container(
                  width: double.infinity,
                  height: 300,
                  child: MapGoogle().buildGoogleMap(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 15),
                child: Text(
                  "Empresas prestadoras del servicio",
                  style: TextStyles.subtitulos(responsive),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
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
                ),

              ),
              const SizedBox(
                height: 20,
              ),
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
                    // Agregar la lógica para abrir el chatbot aquí
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

  Widget buildCards(String imagePath, String url) {
    final uri = Uri.parse(url);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      height: 100,
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
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
