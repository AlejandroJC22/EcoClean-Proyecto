import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_ecoclean/controller/twitter_signIn.dart';
import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/views/forgot_password.dart';
import 'package:flutter_ecoclean/views/register.dart';
import '../controller/email_signIn.dart';
import '../models/inputs.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _loginpageState();
}


class _loginpageState extends State<Login> {
  //Variables contenedoras de datos ingresados
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //Autenticación con la base de datos
  bool _obscureText = true;

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
                  height: 180,
                ),
                SizedBox(height: responsive.inch * 0.03,),
                //Columna inicial
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Contenedor titulo inicial
                    Center(
                      child: Text(
                        "Iniciar Sesión",
                        style: TextStyle(fontSize: responsive.inch * 0.03),
                      ),
                    ),
                    //Espaciado entre campos
                    const SizedBox(
                      height: 30,
                    ),
                    //Input correo electronico
                    TextFieldContainer(child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Correo electrónico',
                        icon: Icon(Icons.person, color:Colors.green[100]),
                        border: InputBorder.none
                      ),
                    )),
      
                    const SizedBox(height: 20,),
        
                    TextFieldContainer(child: TextField(
                      obscureText: _obscureText,
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Contraseña',
                        icon: Icon(Icons.lock, color:Colors.green[100]),
                        suffixIcon: showPassword(),
                        border: InputBorder.none
                      ),
                    )),
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
                                builder: (context) => const ForgotPass()
                              )
                          );
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
                            builder: (context) => const Register(),
                          ));
                        },
                      ),
                    ),
                    //Espaciado entre campos
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget showPassword(){
    return IconButton(onPressed: (){
      setState(() {
        _obscureText = !_obscureText;
      });
    }, icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off), color: Colors.green[100]);
  }
}

