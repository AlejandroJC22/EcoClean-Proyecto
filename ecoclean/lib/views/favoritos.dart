// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/controller/current_location.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/views/favorites_content/mapFavorites.dart';
import 'package:flutter_ecoclean/controller/dialogHelper.dart';
import 'package:flutter_ecoclean/views/favorites_content/mapLocation.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({Key? key}) : super(key: key);
  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

//Vista Rutas favoritas
class _FavoritosScreenState extends State<FavoritosScreen> {

  LocationData? currentLocation;
  CurrentLocation? currentLocationInstance;
  String home = '';
  String work = '';

  TextEditingController addressController = TextEditingController();

  // Método que se llama al inicializar el estado de la pantalla.
  @override
  void initState() {
    super.initState();
    // Inicializar la carga de la información del usuario.
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final Location location = Location();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    try {
      if (user != null) {
        // Obtener el UID del usuario actual
        String uid = user.uid;

        // Obtener datos de la colección 'users' en Firestore
        DocumentSnapshot<Map<String, dynamic>> userDocument =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

        // Asignar los datos a las variables home y work
        setState(() {
          home = userDocument['direccion_casa'] ?? '';
          work = userDocument['direccion_trabajo'] ?? '';
        });
      }

      final LocationData locationData = await location.getLocation();
      setState(() {
        currentLocation = locationData;
        currentLocationInstance = CurrentLocation(currentLocation);
      });
    } catch (e) {
      print("Error obtaining location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    //Obtener la diagonal del dispositivo
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      //Construir la ventana rutas favoritas
        body: SingleChildScrollView(
            child: Column(
                children: [
                  //Espaciado entre campos
                  const SizedBox(
                    height: 20,
                  ),
                  //Contenedor titulo inicial
                  Container(
                      alignment: Alignment.bottomLeft,
                      margin: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Rutas favoritas",
                        style: TextStyles.tituloNegro(responsive),
                      )
                  ),
                  //Espaciado entre campos
                  const SizedBox(
                    height: 15,
                  ),
                  //Contenedor texto interactivo
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: CupertinoButton(
                      onPressed: () async {
                        if (currentLocationInstance != null) {
                          String address = await currentLocationInstance!.getAddressFromCurrentLocation();

                          // Establecer el texto del controlador antes de mostrar el diálogo
                          addressController.text = address;

                          DialogHelper.location(
                            context,
                            address,
                                (locationType) {
                              // Lógica para manejar la selección del tipo de ubicación (Casa o Trabajo)
                              if (locationType == 'Casa') {
                                setState(() {
                                  home = addressController.text;
                                });
                              } else if (locationType == 'Trabajo') {
                                setState(() {
                                  work = addressController.text;
                                });
                              }
                            },
                          );
                        } else {
                          print('No se obtuvo la ubicación');
                        }
                      },
                      child: Row(
                        //Icono de ubicación
                        children: [
                          const Icon(
                            Icons.add_location_alt,
                            color: Colors.red,
                          ),
                          //Espaciado entre campos
                          const SizedBox(width: 15),
                          //Texto identificador
                          Text(
                            "Tu ubicación actual",
                            style: TextStyles.enlaces(responsive),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Contenedor texto interactivo
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: CupertinoButton(
                      child: Row(
                        //Icono de mapa
                        children: [
                          const Icon(
                            Icons.map,
                            color: Colors.red,
                          ),
                          //Espaciado entre campos
                          const SizedBox(width: 15),
                          //Texto identificador
                          Text(
                              "Ver en el mapa",
                              style: TextStyles.enlaces(responsive)
                          ),
                        ],
                      ),
                      //Logica si se oprime el texto
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MapFavoritesPage()));
                      },
                    ),
                  ),
                  //Contenedor identificación de apartado
                  Container(
                    color: const Color.fromARGB(255, 232, 232, 232),
                    width: double.infinity,
                    height: 25,
                    padding: const EdgeInsets.only(left: 15),
                    //Titulo identificador
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'Rutas favoritas',
                          style: TextStyles.preguntas(responsive)
                      ),
                    ),
                  ),
                  //Lista de opciones
                  const Divider(),
                  //Primera opción
                  ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      child: const Icon(Icons.home, size: 32),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        DialogHelper.editProfile(
                          context,
                          'Casa',
                          home,
                              (newHome) {
                            setState(() {
                              home = newHome;
                            });
                          },
                        );
                      },
                      child: const Icon(Icons.edit, color: Colors.grey),
                    ),
                    title: const Text('Casa', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    subtitle: Text(home, style: const TextStyle(color: Colors.black)),
                    onTap: () {
                      if (home == "" || home.isEmpty) {
                        // Si la dirección está vacía, mostrar un diálogo de alerta
                        DialogHelper.showAlertDialog(
                          context,
                          "No hay direcciones",
                          "No se ha ingresado ninguna dirección o se eliminaron las direcciones",
                        );
                      } else {
                        // Si hay una dirección, navegar a la pantalla del mapa
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapLocation(userLocation: home, locationType: 'home'),
                          ),
                        );
                      }
                    },
                  ),
                  //Divisor de campos
                  const Divider(),
                  //Segunda opción
                  ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      child: const Icon(Icons.work, size: 32),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        DialogHelper.editProfile(context, 'Trabajo', work, 
                        (newWork) {
                          setState(() {
                            work = newWork;
                          });
                        },
                        );
                      },
                      child: const Icon(Icons.edit, color: Colors.grey),
                    ),
                    title: const Text('Trabajo', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    subtitle: Text(work, style: const TextStyle(color: Colors.black)),
                    onTap: () {
                      if (work == "" || work.isEmpty) {
                        // Si la dirección está vacía, mostrar un diálogo de alerta
                        DialogHelper.showAlertDialog(
                          context,
                          "No hay direcciones",
                          "No se ha ingresado ninguna dirección o se eliminaron las direcciones",
                        );
                      } else {
                        // Si hay una dirección, navegar a la pantalla del mapa
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapLocation(userLocation: work, locationType: 'work'),
                          ),
                        );
                      }
                    },
                  ),
                  //Divisor de campos
                  const Divider(),
                  //Espaciado entre campos
                  const SizedBox(
                    height: 10,
                  ),
                  //Contenedor identificador de apartado
                  Container(
                    //Decoración y tamaño
                    color: const Color.fromARGB(255, 232, 232, 232),
                    width: double.infinity,
                    height: 25,
                    //Alineación y espaciado
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      //Texto identificador
                      child: Text(
                        'Editar rutas favoritas',
                        style: TextStyles.preguntas(responsive)
                      ),
                    ),
                  ),
                  //Espaciado entre campos
                  const SizedBox(height: 10,),
                  //Contenedor boton eliminar
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: CupertinoButton(
                      child: Text(
                        "Eliminar rutas",
                          style: TextStyles.salidas(responsive)
                      ),
                      //Logica al oprimir el texto
                      onPressed: () {
                        DialogHelper.confirmDialog(context);
                      },
                    ),
                  ),
                ]
            )
        )
    );
  }
}
