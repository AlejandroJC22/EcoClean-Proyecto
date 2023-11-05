import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/views/menu.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
Future<UserCredential?> signInWithGoogleAndSaveToFirestore(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // El usuario canceló el inicio de sesión con Google.
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Iniciar sesión con las credenciales de Google.
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    final User? user = userCredential.user;

    if (user != null) {
      // Crear una referencia a la colección "prueba" en Cloud Firestore
      final CollectionReference pruebaCollection = FirebaseFirestore.instance.collection('prueba');

      // Verificar si el usuario ya existe en Cloud Firestore
      final QuerySnapshot existingUser = await pruebaCollection.where('uid', isEqualTo: user.uid).get();

      if (existingUser.docs.isEmpty) {
        // El usuario no existe en Firestore, así que lo agregamos
        await pruebaCollection.add({
          'uid': user.uid,
          'nombre': user.displayName,
          'correo': user.email,
          'imagenURL': user.photoURL,
        });

        print('Usuario agregado a Firestore.');
      } else {
        print('El usuario ya existe en Firestore.');
      }

      return userCredential;
    } else {
      return null;
    }
  } catch (error) {
    // Manejar errores, por ejemplo, mostrar un mensaje al usuario.
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

