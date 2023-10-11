import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecoclean/utilidades/responsive.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Registrarse',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: 'Impact',
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          
          child: Column(
            children: [
              Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Correo",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.ip(5),
                          fontFamily: 'Impact',
                          color: Colors.red),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _inputUser(),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Contraseña",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.ip(5),
                          fontFamily: 'Impact',
                          color: Colors.red),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _inputContrasena(),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Confirmar contraseña",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.ip(5),
                          fontFamily: 'Impact',
                          color: Colors.red),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _inputContrasena(),
                  Container(
                    alignment: Alignment.center,
                    child: CupertinoButton(
                      child: Text(
                        "Acepto los Terminos y Condiciones del servicio",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.ip(4),
                            fontFamily: 'Impact',
                            color: Colors.grey),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width - 30,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: Text("Registrarse",
                            style: TextStyle(fontSize: responsive.ip(5))),
                      )),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: const Text("O continua con tu red social favorita"),
                  ),
                  const SizedBox(height: 15),
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
                        child: Image.asset('lib/iconos/google.png', height: 30),
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _inputUser() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ));
  }

  Container _inputContrasena() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          style: const TextStyle(fontSize: 20),
          obscureText: true,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ));
  }
}
