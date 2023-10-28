import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';

class Edit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                'Editar perfil',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: responsive.ip(5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            )
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://cdn.icon-icons.com/icons2/3300/PNG/512/u_letter_letters_alphabet_icon_208967.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: Colors.white),
                          color: Colors.red,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Nombre de usuario'),
                      subtitle: Text('Tu nombre de usuario'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Agregar lógica para editar el nombre de usuario
                        },
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Correo electrónico'),
                      subtitle: Text('tucorreo@example.com'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Agregar lógica para editar el correo electrónico
                        },
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Contraseña'),
                      subtitle: Text('********'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Agregar lógica para editar el correo electrónico
                        },
                      ),
                    ),
                    Divider(),
                    const ListTile(
                      title: Text('Conexiones sociales', textAlign: TextAlign.center),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor:
                          const Color.fromARGB(255, 66, 103, 178),
                          child: Image.asset('lib/iconos/facebook.png',
                              color: Colors.white, height: 30),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Colors.white,
                          child:
                          Image.asset('lib/iconos/google.png', height: 30),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Colors.black,
                          child: Image.asset(
                            'lib/iconos/twitter.png',
                            color: Colors.white,
                            height: 30,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                        height: 20
                    ),
                    Container(
                      color: const Color.fromARGB(255, 232, 232, 232),
                      width: double.infinity,
                      height: 25,
                      padding: const EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Control de la cuenta',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: responsive.ip(4),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: CupertinoButton(
                        child: Text(
                          "Añadir otra cuenta",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(4),
                              fontFamily: 'Impact',
                              color: Colors.black),
                        ),
                        onPressed: () {

                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: CupertinoButton(
                        child: Text(
                          "Eliminar cuenta",
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
