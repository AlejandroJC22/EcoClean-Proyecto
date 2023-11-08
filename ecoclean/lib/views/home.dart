import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';

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
      print('Usuario actual: ${user.uid}'); // Agrega una impresión para verificar el usuario actual
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;

        print('Datos del usuario cargados: $userData'); // Agrega una impresión para los datos del usuario

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
                  style: TextStyles.textoNegro(responsive),
                )
            ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: double.infinity,
              height: 300,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 15),
            child: Text(
              "Empresas prestadoras del servicio",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: responsive.ip(4),
                fontFamily: 'Impact',
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: double.infinity,
              height: 100,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: ListTile(
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
          ),
          ],
        ),
      ),
      ),
    );
  }
}
