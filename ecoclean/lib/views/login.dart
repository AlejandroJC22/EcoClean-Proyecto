import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecoclean/controller/google_signIn.dart';
import 'package:flutter_ecoclean/controller/twitter_signIn.dart';
import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/views/menu.dart';
import 'package:flutter_ecoclean/views/register.dart';
import '../controller/facebook_signIn.dart';
import '../models/inputs.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _loginpageState();
}

class _loginpageState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();


  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/iconos/logoApp.png',
                  height: 200,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Iniciar Sesión",
                        style: TextStyles.tituloNegro(responsive),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Inputs(
                        controller: emailController,
                        labelText: "Correo electronico",
                        obscureText: false
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Inputs(
                        controller: passwordController,
                        labelText: "Contraseña",
                        obscureText: true
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width - 30,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: Text("Iniciar Sesión", style: TextStyle(fontSize: responsive.ip(5), color: Colors.white)),
                        onPressed: () async {
                          final String email = emailController.text;
                          final String password = passwordController.text;

                          if (email.isEmpty || password.isEmpty) {
                            _showAlertDialog("Ingresa datos", "Por favor ingresa el correo y la contraseña.");
                            return;
                          }

                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            User? user = userCredential.user;
                            print('Signed in: ${user!.uid}');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Menu()));
                          } catch (e) {
                            print('Sign-in error: $e');
                            _showAlertDialog("Verifica los datos", "Usuario o contraseña incorrectos.");
                          }
                        },
                      ),),
                    Container(
                      alignment: Alignment.center,
                      child: CupertinoButton(
                        child: Text(
                          "¿Olvidaste tu contraseña?",
                          style: TextStyles.preguntas(responsive),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: CupertinoButton(
                        child: Text(
                          "Registrate aquí",
                          style: TextStyles.enlaces(responsive),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register(),
                          ));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
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
                          onPressed: () async {
                            final user = await _firebaseAuthService.signInWithFacebook();
                            if (user != null) {
                              print('Inicio de sesión exitoso: ${user.displayName}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Menu()),
                              );
                            }
                          },
                          backgroundColor: const Color.fromARGB(255, 66, 103, 178),
                          child: Image.asset('lib/iconos/facebook.png', color: Colors.white, height: 30),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(
                          onPressed: () async {
                            await signInWithGoogleAndSaveData(context);

                          },
                          backgroundColor: Colors.white,
                          child: Image.asset('lib/iconos/google.png', height: 30),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(
                          onPressed: () async {
                            await signInWithTwitter(context);
                          },
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
  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }
}
