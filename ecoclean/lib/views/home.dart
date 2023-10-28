import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _homeState();
}

class _homeState extends State<Home> {

  String username = ""; // Variable para almacenar el nombre de usuario

  @override
  void initState() {
    super.initState();
    _loadUsername(); // Carga el nombre de usuario al iniciar la pantalla
  }

  // Función para cargar el nombre de usuario desde SharedPreferences
  _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
        body: SingleChildScrollView(
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
              const SizedBox(
                  height: 20
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  height: 300,

                ),
              ),
              const SizedBox(
                  height: 30
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
                        fontFamily: 'Impact'
                    ),
                  )
              ),
              const SizedBox(
                  height: 15
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  height: 100,
                ),
              ),
              const SizedBox(
                  height: 20
              ),
              Container(
                child: ListTile(
                  title: Text(
                      '¿Tienes dudas?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.ip(4),
                        fontFamily: 'Impact',
                      ),
                      textAlign: TextAlign.center
                  ),
                  subtitle: Text(
                      'Pregúntale a nuestro ChatBot',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.ip(4),
                        fontFamily: 'Impact',
                      ),
                      textAlign: TextAlign.center
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
              )
            ],
          ),
        )
    );
  }
}
