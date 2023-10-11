import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecoclean/utilidades/responsive.dart';

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
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.ip(5),
                      fontFamily: 'Impact'
                  ),
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.ip(4),
                        fontFamily: 'Impact',
                        color: Colors.red,
                      ),
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.ip(4),
                        fontFamily: 'Impact',
                        color: Colors.red,
                      ),
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
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: responsive.ip(4),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Container(
                width: 48, // Ajusta el ancho según tus necesidades
                height: 48, // Ajusta la altura según tus necesidades
                alignment: Alignment.center,
                child: const Icon(Icons.house_sharp,
                    size: 32), // Ajusta el tamaño del icono
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
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: responsive.ip(4),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              alignment: Alignment.bottomLeft,
              child: CupertinoButton(
                child: Text(
                  "Eliminar ruta",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.ip(4),
                    fontFamily: 'Impact',
                    color: Colors.red),
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
