import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/controller/google_signIn.dart';
import 'package:flutter_ecoclean/controller/terms_and_privacy.dart';
import 'package:flutter_ecoclean/controller/twitter_signIn.dart';
import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/views/forgot_password.dart';
import 'package:flutter_ecoclean/views/menu.dart';
import 'package:flutter_ecoclean/views/register.dart';
import '../controller/email_signIn.dart';
import '../controller/facebook_signIn.dart';
import '../models/inputs.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _loginpageState();
}


class _loginpageState extends State<Login> {
  //Variables contenedoras de datos ingresados
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //Autenticación con la base de datos
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  //Construir la vista
  @override
  Widget build(BuildContext context) {
    //Obtener la diagonal del dispositivo
    final Responsive responsive = Responsive.of(context);
    return SafeArea(
      child: Scaffold(
        //Color del fondo
        backgroundColor: Colors.white,
        //Cuerpo de la ventana
        body: Center(
          child: SingleChildScrollView(
            //Columna de posicionamiento de campos
            child: Column(
              //Alineación de los campos
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Icono de la aplicación
                Image.asset(
                  'lib/iconos/logo.png',
                  height: 200,
                ),
                //Columna inicial
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Contenedor titulo inicial
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Iniciar Sesión",
                        style: TextStyles.tituloNegro(responsive),
                      ),
                    ),
                    //Espaciado entre campos
                    const SizedBox(
                      height: 30,
                    ),
                    //Input correo electronico
                    Inputs(
                        controller: emailController,
                        labelText: "Correo electronico",
                        obscureText: false
                    ),
                    //Espaciado entre campos
                    const SizedBox(
                      height: 15,
                    ),
                    //input contraseña
                    Inputs(
                        controller: passwordController,
                        labelText: "Contraseña",
                        obscureText: true
                    ),
                    //Contenedor boton inicio sesión
                    Container(
                      //Alineación y tamaño
                      margin: const EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width - 30,
                      height: 50,
                      //Diseño del boton
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        //texto identificador
                        child: Text("Iniciar Sesión", style: TextStyle(fontSize: responsive.ip(5), color: Colors.white)),
                        //Logica al oprimir el boton
                        onPressed: () async {
                          //Convertir los datos ingresados a texto
                          final String email = emailController.text;
                          final String password = passwordController.text;
                          //Validar los datos ingresados con la base de datos
                          signInWithEmail(context, email, password);
                        },
                      ),
                    ),
                    //Contenedor texto interactivo
                    Container(
                      alignment: Alignment.center,
                      child: CupertinoButton(
                        //Texto informativo
                        child: Text(
                          "¿Olvidaste tu contraseña?",
                          style: TextStyles.preguntas(responsive),
                        ),
                        //Logica al oprimir el texto
                        onPressed: () {
                          //Navegar a la pantalla de olvido de contraseña
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPass()));
                        },
                      ),
                    ),
                    //Contenedor texto informativo
                    Container(
                      alignment: Alignment.center,
                      child: CupertinoButton(
                        //texto informativo
                        child: Text(
                          "Registrate aquí",
                          style: TextStyles.enlaces(responsive),
                        ),
                        //Logica al oprimir el texto
                        onPressed: () {
                          //Navegar a la pantalla de registro
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register(),
                          ));
                        },
                      ),
                    ),
                    //Espaciado entre campos
                    const SizedBox(
                      height: 15,
                    ),
                    //Contenedor texto informativo
                    Container(
                      alignment: Alignment.bottomCenter,
                      //Texto informativo
                      child: const Text("O continua con tu red social favorita"),
                    ),
                    //Espaciado entre campos
                    const SizedBox(height: 15),
                    //Fila de botones
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Boton Facebook
                        FloatingActionButton(
                          //Logica al oprimir el boton
                          onPressed: () async {
                            //Validar los datos de inicio con Facebook
                            final user = await _firebaseAuthService.signInWithFacebook();
                            //Si se acepta el ingreso
                            if (user != null) {
                              //Navegar a la pantalla inicial
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Menu()),
                              );
                            }
                          },
                          //Decoración del boton
                          backgroundColor: const Color.fromARGB(255, 66, 103, 178),
                          child: Image.asset('lib/iconos/facebook.png', color: Colors.white, height: 30),
                        ),
                        //Espaciado entre campos
                        const SizedBox(
                          width: 10,
                        ),
                        //Boton Google
                        FloatingActionButton(
                          //Logica al oprimir el boton
                          onPressed: () async {
                            //Validar el ingreso con google
                            await signInWithGoogleAndSaveData(context);
                          },
                          //Decoración del boton
                          backgroundColor: Colors.white,
                          child: Image.asset('lib/iconos/google.png', height: 30),
                        ),
                        //Espaciado entre campos
                        const SizedBox(
                          width: 10,
                        ),
                        //Boton Twitter
                        FloatingActionButton(
                          //Logica al oprimir el boton
                          onPressed: () async {
                            //Validar el ingreso con twitter
                            await signInWithTwitter(context);
                          },
                          //Decoración del boton
                          backgroundColor: Colors.black,
                          child: Image.asset(
                            'lib/iconos/twitter.png',
                            color: Colors.white,
                            height: 30,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 9,),
                    Container(
                      child: TextAndPrivacy.getRichText(context),
                    ),
                    SizedBox(height: 5,)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
