// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/controller/dialogHelper.dart';
import '../views/menu.dart';

//Clase para autenticar al usuario a la base de datos por correo electronico
Future<User?> signInWithEmail(BuildContext context, String email, String password) async{

  try{
    // Solicitar acceso al correo electrónico con los datos ingresados
    UserCredential userCredential = await FirebaseAuth.instance.
    signInWithEmailAndPassword(email: email, password: password);

    // Si los datos coinciden con la base de datos, ingresar a la pantalla inicial
    User? user = userCredential.user;
    print('Signed in: ${user!.uid}');
    Navigator.push(context,MaterialPageRoute(builder: (context) => const Menu()));

    // Si los datos no coinciden con la base de datos, mostrar error
  } catch (e) {
    print('Sign-in error: $e');
    DialogHelper.showAlertDialog(context, "Verifica los datos", "Usuario o contraseña incorrectos.");
  }
  return null;
  }
