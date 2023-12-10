import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/models/texto.dart';

//Vista Rutas favoritas
class Favorites extends StatelessWidget {
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
                              style: TextStyles.enlaces(responsive)
                          ),
                        ],
                      ),
                      //Logica si se oprime el texto
                      onPressed: () {},
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
                      onPressed: () {},
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
                          'Agregar rutas favoritas',
                          style: TextStyles.preguntas(responsive)
                      ),
                    ),
                  ),
                  //Lista de opciones

                  //Primera opción
                  ListTile(
                    leading: Container(
                      //Alineación y tamaño
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      child: const Icon(Icons.house_sharp,
                          size: 32),
                    ),
                    //Icono identificador parte derecha
                    trailing: const Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey),
                    //Titulo del campo
                    title: const Text('Casa',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    //Subtitulo del campo
                    subtitle: const Text('Pulsa para editar',
                        style: TextStyle(color: Colors.black)),
                    //Logica al oprimir el campo
                    onTap: () {},
                  ),
                  //Divisor de campos
                  Divider(),
                  //Segunda opción
                  ListTile(
                    leading: Container(
                      //Alineación y tamaño
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      child: const Icon(Icons.work, size: 32),
                    ),
                    //Icono identificador parte derecha
                    trailing: const Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey),
                    //Titulo del campo
                    title: const Text('Trabajo',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    //Subtitulo del campo
                    subtitle: const Text('Pulsa para editar',
                        style: TextStyle(color: Colors.black)),
                    //Logica al oprimir el campo
                    onTap: () {},
                  ),
                  //Divisor de campos
                  Divider(),
                  //Tercera opción
                  ListTile(
                    //Alineación y tamaño
                    leading: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      child: const Icon(Icons.add_location,
                          size: 32),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey),
                    //Titulo del campo
                    title: const Text('Nueva ruta',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    //Subtitulo del campo
                    subtitle: const Text('Pulsa para agregar',
                        style: TextStyle(color: Colors.black)),
                    //Logica al oprimir el campo
                    onTap: () {},
                  ),
                  //Divisor de campos
                  Divider(),
                  //Espaciado entre campos
                  const SizedBox(
                    height: 80,
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
                  SizedBox(height: 10,),
                  //Contenedor boton eliminar
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: CupertinoButton(
                      child: Text(
                        "Eliminar ruta",
                          style: TextStyles.salidas(responsive)
                      ),
                      //Logica al oprimir el texto
                      onPressed: () {},
                    ),
                  ),
                ]
            )
        )
    );
  }
}
