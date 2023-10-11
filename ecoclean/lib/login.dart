import 'package:ecoclean/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecoclean/register.dart';
import 'package:ecoclean/utilidades/responsive.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add, color: Colors.red),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Menu()));
              },
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Eco \n Clean",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.ip(10),
                      fontFamily: 'Impact'),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Iniciar Sesión",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.ip(7),
                            fontFamily: 'Impact'),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
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
                    Container(
                        margin: const EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width - 30,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: Text("Iniciar Sesión",
                              style: TextStyle(fontSize: responsive.ip(5))),
                        )),
                    Container(
                      alignment: Alignment.center,
                      child: CupertinoButton(
                        child: Text(
                          "¿Olvidaste tu contraseña?",
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
                      alignment: Alignment.center,
                      child: CupertinoButton(
                        child: Text(
                          "Registrate aquí",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(4),
                              fontFamily: 'Impact',
                              color: Colors.red),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register(),
                          ));
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child:
                          const Text("O continua con tu red social favorita"),
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
                    )
                  ],
                )
              ],
            ),
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
