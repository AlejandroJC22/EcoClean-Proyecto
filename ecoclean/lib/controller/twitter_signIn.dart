import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_login/twitter_login.dart';

import '../views/menu.dart';

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

Future<UserCredential?> signInWithTwitter(BuildContext context) async {
  try {
    final _twitterLogin = TwitterLogin(
      apiKey: "wnf0YP5CAooFyJ5r1nHX5SC3t",
      apiSecretKey: "zzgAOuUszzRQIDSpiZlvdpQlTImXaIjqj0oYuW3Yzausvlnur0",
      redirectURI: "https://prueba-bd-81b78.firebaseapp.com/__/auth/handler",
    );

    // Solicitar acceso al correo electrónico
    final twitterLoginResult = await _twitterLogin.login();

    if (twitterLoginResult.status == TwitterLoginStatus.loggedIn) {
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: twitterLoginResult.authToken!,
        secret: twitterLoginResult.authTokenSecret!,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
      final User? user = userCredential.user;

      if (user != null) {
        // Utiliza el mismo ID en autenticación y Firestore
        final userId = user.uid;

        // Crear una referencia a la colección "prueba" en Cloud Firestore
        final CollectionReference pruebaCollection = FirebaseFirestore.instance.collection('users');

        // Verificar si el usuario ya existe en Cloud Firestore
        final QuerySnapshot existingUser = await pruebaCollection.where('uid', isEqualTo: userId).get();

        if (existingUser.docs.isEmpty) {
          // El usuario no existe en Firestore, así que lo agregamos
          String correo = user.email ?? ""; // Maneja el correo nulo
          await pruebaCollection.doc(userId).set({
            'uid': userId,
            'nombre': user.displayName,
            'correo': correo,
            'imagenURL': user.photoURL ?? "",
            'provider': "Twitter"
          });

          print('Usuario agregado a Firestore.');
        } else {
          print('El usuario ya existe en Firestore.');
        }

        // Redirigir al usuario a la pantalla de menú
        showMenuScreen(context); // Asegúrate de que 'context' esté disponible

        return userCredential;
      } else {
        return null;
      }
    }
  } catch (error) {
    // Manejar errores, por ejemplo, mostrar un mensaje al usuario.
    print('Error al iniciar sesión con Twitter: $error');
  }
  return null;
}

