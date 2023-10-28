import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:twitter_login/twitter_login.dart';

final _twitterLogin = TwitterLogin(
  apiKey: "MTPuMJM895qnqtB8tDQ8AGGIn",
  apiSecretKey: "Xv44NAOpO830uwVd4bPixfjRoFmolbSaWoTbKtrCEmNA8wDT6n",
  redirectURI: "https://prueba-bd-81b78.firebaseapp.com/__/auth/handler",
);

Future<User?> signInWithTwitter(BuildContext context) async {
  final authResult = await _twitterLogin.login(); // Esperar a que la autenticación se complete

  switch (authResult.status) {
    case TwitterLoginStatus.loggedIn:
    // El usuario ha iniciado sesión correctamente
    // Puedes continuar con el proceso de autenticación y Firebase aquí
      break;
    case TwitterLoginStatus.cancelledByUser:
    // El usuario canceló la autenticación
    // Puedes manejar esta situación de acuerdo a tus necesidades
      break;
    case TwitterLoginStatus.error:
    // Hubo un error durante la autenticación
    // Puedes manejar el error y mostrar un mensaje al usuario
      print('Error en la autenticación de Twitter: ${authResult.errorMessage}');
      break;
    case null:
  }
}
