import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/models/texto.dart';

class Favorites extends StatelessWidget {
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
                        "Rutas favoritas",
                        style: TextStyles.tituloNegro(responsive),
                      )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: CupertinoButton(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add_location_alt,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 15),
                          Text(
                              "Tu ubicación actual",
                              style: TextStyles.enlaces(responsive)
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: CupertinoButton(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.map,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 15),
                          Text(
                              "Ver en el mapa",
                              style: TextStyles.enlaces(responsive)
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    color: const Color.fromARGB(255, 232, 232, 232),
                    width: double.infinity,
                    height: 25,
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'Editar rutas favoritas',
                          style: TextStyles.preguntas(responsive)
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      width: 48,
                      height: 48,
                      alignment: Alignment.center,
                      child: const Icon(Icons.house_sharp,
                          size: 32),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey),
                    title: const Text('Casa',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    subtitle: const Text('Pulsa para editar',
                        style: TextStyle(color: Colors.black)),
                    onTap: () {
                      // Agrega la lógica para manejar el toque del ListTile
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Container(
                      width: 48, // Ajusta el ancho según tus necesidades
                      height: 48, // Ajusta la altura según tus necesidades
                      alignment: Alignment.center,
                      child: const Icon(Icons.work, size: 32), // Ajusta el tamaño del icono
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey),
                    title: const Text('Trabajo',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    subtitle: const Text('Pulsa para editar',
                        style: TextStyle(color: Colors.black)),
                    onTap: () {
                      // Agrega la lógica para manejar el toque del ListTile
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Container(
                      width: 48, // Ajusta el ancho según tus necesidades
                      height: 48, // Ajusta la altura según tus necesidades
                      alignment: Alignment.center,
                      child: const Icon(Icons.add_location,
                          size: 32), // Ajusta el tamaño del icono
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey),
                    title: const Text('Nueva ruta',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    subtitle: const Text('Pulsa para agregar',
                        style: TextStyle(color: Colors.black)),
                    onTap: () {
                      // Agrega la lógica para manejar el toque del ListTile
                    },
                  ),
                  Divider(),
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    color: const Color.fromARGB(255, 232, 232, 232),
                    width: double.infinity,
                    height: 25,
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Editar rutas favoritas',
                        style: TextStyles.preguntas(responsive)
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: CupertinoButton(
                      child: Text(
                        "Eliminar ruta",
                          style: TextStyles.salidas(responsive)
                      ),
                      onPressed: () {

                      },
                    ),
                  ),
                ]
            )
        )
    );
  }
}
