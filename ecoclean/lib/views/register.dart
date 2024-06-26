// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecoclean/controller/facebook_signIn.dart';
import 'package:flutter_ecoclean/controller/google_signIn.dart';
import 'package:flutter_ecoclean/controller/terms_and_privacy.dart';
import 'package:flutter_ecoclean/models/floatings_buttons.dart';
import 'package:flutter_ecoclean/models/inputs.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/views/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecoclean/controller/dialogHelper.dart';
import 'package:flutter_ecoclean/views/menu.dart';

// Llamamos a la pantalla Register
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

// Creamos la lógica de la pantalla register
class _RegisterState extends State<Register> {

  // Almacenamos los datos que se ingresan en pantalla en variables editables
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  bool _obscureText = true;


  // Limpiamos los campos de texto
  void _clearFields() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  // Creamos la función que nos permite vincularnos a la base de datos
  Future<void> _registerUser() async {
    // Almacenamos los datos ingresados como texto para poder modificarlos
    final String username = usernameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;
    

    // Validamos que en los campos hayan datos
    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      DialogHelper.showAlertDialog(context,"Registro Fallido", "Por favor, ingresa todos los datos.");
      return;
    }
    // Validamos el formato del correo electrónico
    if (!email.contains('@') || (!email.endsWith('.com') && !email.endsWith('.co'))) {
      DialogHelper.showAlertDialog(context,"Registro Fallido", "El correo electrónico no es válido.");
      return;
    }
    // Verificamos que la contraseña tenga más de 6 caracteres
    if (password.length <= 5) {
      DialogHelper.showAlertDialog(context,"Registro Fallido", "La contraseña debe tener al menos 6 caracteres.");
      return;
    }
    // Validamos que la contraseña sea la misma
    if (password != confirmPassword) {
      DialogHelper.showAlertDialog(context,"Registro Fallido", "Las contraseñas no coinciden");
    } else {
      // Si las contraseñas coinciden, autenticamos al usuario en la base de datos
      try {
        final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final User? user = userCredential.user;

        if (user != null) {

          final userId = user.uid;
          // Crear una referencia a la colección "prueba" en Cloud Firestore
          final CollectionReference pruebaCollection = FirebaseFirestore.instance.collection('users');

          // Verificar si el usuario ya existe en Cloud Firestore
          final QuerySnapshot existingUser = await pruebaCollection.where('uid', isEqualTo: userId).get();

          if (existingUser.docs.isEmpty) {
            // El usuario no existe en Firestore, así que lo agregamos
            await pruebaCollection.doc(userId).set({
              'uid': userId,
              'nombre': username,
              'correo': email,
              'imagenURL': 'https://static.vecteezy.com/system/resources/previews/008/442/086/non_2x/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg',
              'provider': "Email"
            });
          }
          DialogHelper.showAlertDialogRegister(context,"Registro Exitoso", "Se ha completado el registro, por favor inicie sesión.");
          _clearFields();

        } else {
          // Mostramos un mensaje de error en caso de que no se almacenen los datos en la base de datos
          DialogHelper.showAlertDialog(context,"Registro Fallido", "No se pudo obtener el UID del usuario.");
        }
      } catch (error) {
        // No se borran los campos en caso de un error
        DialogHelper.showAlertDialog(context,"Error al registrar", "El usuario ya existe, por favor inicie sesión");
      }
    }
  }

  @override
  // Creamos la vista
  Widget build(BuildContext context) {
    // Importamos la librería para los tamaños de texto
    final Responsive responsive = Responsive.of(context);
    // Condicionamos para que se establezcan bordes en la vista
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Esto quitará la flecha de retroceso
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centra los elementos horizontalmente
            children: <Widget>[
              Image.asset("lib/iconos/logoApp.png", width: 32, height: 32),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            // Alineamos a la izquierda todos los datos
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Margen entre textos
              const SizedBox(height: 15),
              Center(
                child: Text(
                  "Registrarse",
                  style: TextStyle(fontSize: responsive.inch * 0.03),
                ),
              ),
              // Margen entre textos
              const SizedBox(height: 30),
              TextFieldContainer(child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Nombre',
                    icon: Icon(Icons.person, color:Colors.green[100]),
                    border: InputBorder.none
                  ),
                )),

                const SizedBox(height: 20,),

                TextFieldContainer(child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Correo electrónico',
                    icon: Icon(Icons.mail, color:Colors.green[100]),
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

                const SizedBox(height: 20,),

                TextFieldContainer(child: TextField(
                  obscureText: _obscureText,
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Confirma la contraseña',
                    icon: Icon(Icons.lock, color:Colors.green[100]),
                    suffixIcon: showPassword(),
                    border: InputBorder.none
                  ),
                )),
              // Margen entre textos
              const SizedBox(height: 15),
              // Creamos un botón para validar los datos y enviarlos a la base de datos
              Container(
                margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  // Llamamos a la función que valida todos los datos según condiciones
                  onPressed: _registerUser,
                  child: Text(
                    "Registrarse",
                    style: TextStyle(fontSize: responsive.ip(5), color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // En caso de tener cuenta, volvemos a la pantalla de inicio de sesión
              Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "¿Tienes una cuenta? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      child: const Text(
                        "Ingresar",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      // Volvemos a la pantalla de inicio de sesión
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
                      },
                    ),
                  ],
                ),
              ),
              // Margen entre textos
              const SizedBox(height: 15),
              const Center(
                child: Text('O continua con', style: TextStyle(fontSize: 16),),
              ),
              const SizedBox(height: 10),
              //Fila de botones
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Boton Facebook
                  buildFloatingButton(
                    imagePath: 'lib/iconos/facebook.png',
                    onTap: () async {
                      //Validar los datos de inicio con Facebook
                      final user = await _firebaseAuthService.signInWithFacebook();
                      //Si se acepta el ingreso
                      if (user != null) {
                        //Navegar a la pantalla inicial
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Menu()),
                        );
                      }
                    },
                  ),

                  //Espaciado entre campos
                  const SizedBox(
                    width: 10,
                  ),

                  //Boton Google
                  buildFloatingButton(
                    imagePath: 'lib/iconos/google.png',
                    onTap: () async {
                      //Validar el ingreso con google
                      await signInWithGoogleAndSaveData(context);
                    },
                  )
                  //Boton Twitter
                  //FloatingActionButton(
                  //  //Logica al oprimir el boton
                  //  onPressed: () async {
                  //    //Validar el ingreso con twitter
                  //    await signInWithTwitter(context);
                  //  },
                  //  //Decoración del boton
                  //  backgroundColor: Colors.black,
                  //  child: Image.asset(
                  //    'lib/iconos/twitter.png',
                  //    color: Colors.white,
                  //    height: 30,
                  //  ),
                  //)
                ],
              ),
              SizedBox(height: responsive.inch * 0.03,),
              Container(
                child: TextAndPrivacy.getRichText(context),
              ),              
              SizedBox(height: responsive.inch * 0.05,),
            ],
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
