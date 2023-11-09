import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/views/menu.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Clase para mostrar la pantalla inicial si se autentica con exito
Future<void> showMenuScreen(BuildContext context) async {
  // Navegar a la pantalla de menú después de iniciar sesión exitosamente.
  await Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) {
        return Menu();
      },
    ),
  );
}

//Clase para autenticar al usuario a la base de datos por google
Future<UserCredential?> signInWithGoogleAndSaveToFirestore(BuildContext context) async {
  try {
    // Solicitar acceso al correo electrónico
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // El usuario canceló el inicio de sesión con Google.
      return null;
    }
    //Accedemos al perfil publico y los datos publicos del usuario
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    //Almacenamos los datos publicos del usuario
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Iniciar sesión con las credenciales de Google.
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    //Almacenamos las credenciales del usuario en una variable
    final User? user = userCredential.user;

    //Verificamos si las credenciales contienen datos
    if (user != null) {

      final userId = user.uid;
      // Crear una referencia a la colección "users" en Cloud Firestore
      final CollectionReference pruebaCollection = FirebaseFirestore.instance.collection('users');

      // Verificar si el usuario ya existe en Cloud Firestore
      final QuerySnapshot existingUser = await pruebaCollection.where('uid', isEqualTo: userId).get();

      if (existingUser.docs.isEmpty) {
        // El usuario no existe en Firestore, así que lo agregamos con los datos del usuario
        await pruebaCollection.doc(userId).set({
          'uid': userId,
          'nombre': user.displayName,
          'correo': user.email,
          'imagenURL': user.photoURL,
          'provider': "Google"
        });

        //Si es primer ingreso, almacenamos los datos y mostramos la pantalla inicial
        print('Usuario agregado a Firestore.');
        Navigator.push(context, MaterialPageRoute(builder: (context) => Menu()));

      } else {
        //Si ya estaba registrado mostramos la pantalla inicial sin almacenar datos
        print('El usuario ya existe en Firestore.');
        showMenuScreen(context);
      }

      return userCredential;
    } else {
      return null;
    }
  } catch (error) {
    //Mostrar error si no se puede iniciar sesion con google
    print('Error al iniciar sesión con Google: $error');
    return null;
  }
}

// Llama a esta función para iniciar sesión con Google y guardar en Firestore
Future<void> signInWithGoogleAndSaveData(BuildContext context) async {
  final userCredential = await signInWithGoogleAndSaveToFirestore(context);
  if (userCredential != null) {
    // Usuario inició sesión con Google
    // Verificar si el usuario ya existe en Firestore
    final User? user = userCredential.user;
    if (user != null) {
      final pruebaCollection = FirebaseFirestore.instance.collection('prueba');
      final existingUser = await pruebaCollection.where('uid', isEqualTo: user.uid).get();

      if (existingUser.docs.isNotEmpty) {
        // Usuario ya existe en Firestore, redirigir a la pantalla de menú
        Navigator.push(context, MaterialPageRoute(builder: (context) => Menu()));
        return;
      }
    }

    // Usuario no existe en Firestore, continuar en la pantalla actual
  } else {
    signInWithGoogleAndSaveToFirestore(context);
  }
}
