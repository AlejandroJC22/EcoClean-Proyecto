//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import '../views/menu.dart';
//
////Clase para mostrar la pantalla inicial si se autentica con exito
//Future<void> showMenuScreen(BuildContext context) async {
//  // Navegar a la pantalla de menú después de iniciar sesión exitosamente.
//  await Navigator.of(context).pushReplacement(
//    MaterialPageRoute(
//      builder: (context) {
//        return Menu();
//      },
//    ),
//  );
//}
////Clase para autenticar al usuario a la base de datos por twitter
//Future<UserCredential?> signInWithTwitter(BuildContext context) async {
//  try {
//    //Almacenamos las llaves de acceso de twitter en variables
//    final _twitterLogin = TwitterLogin(
//      apiKey: "wnf0YP5CAooFyJ5r1nHX5SC3t",
//      apiSecretKey: "zzgAOuUszzRQIDSpiZlvdpQlTImXaIjqj0oYuW3Yzausvlnur0",
//      redirectURI: "https://prueba-bd-81b78.firebaseapp.com/__/auth/handler",
//    );
//
//    // Solicitar acceso a la cuenta de twitter
//    final twitterLoginResult = await _twitterLogin.login();
//
//    //Si la autenticacion fue exitosa
//    if (twitterLoginResult.status == TwitterLoginStatus.loggedIn) {
//      //Almacenamos las llaves de acceso del usuario en variables
//      final twitterAuthCredential = TwitterAuthProvider.credential(
//        accessToken: twitterLoginResult.authToken!,
//        secret: twitterLoginResult.authTokenSecret!,
//      );
//      //Almacenamos las credenciales en Firebase
//      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
//      //Almacenamos las credenciales del usuario en una variable
//      final User? user = userCredential.user;
//
//      //Verificamos si las credenciales contienen datos
//      if (user != null) {
//        // Utiliza el mismo ID en autenticación y Firestore
//        final userId = user.uid;
//
//        // Crear una referencia a la colección "users" en Cloud Firestore
//        final CollectionReference pruebaCollection = FirebaseFirestore.instance.collection('users');
//
//        // Verificar si el usuario ya existe en Cloud Firestore
//        final QuerySnapshot existingUser = await pruebaCollection.where('uid', isEqualTo: userId).get();
//
//        if (existingUser.docs.isEmpty) {
//          // El usuario no existe en Firestore, así que lo agregamos
//          String correo = user.email ?? "";
//          await pruebaCollection.doc(userId).set({
//            'uid': userId,
//            'nombre': user.displayName,
//            'correo': correo,
//            'imagenURL': user.photoURL ?? "",
//            'provider': "Twitter"
//          });
//
//          print('Usuario agregado a Firestore.');
//        } else {
//          print('El usuario ya existe en Firestore.');
//        }
//        // Redirigir al usuario a la pantalla de menú
//        showMenuScreen(context); // Asegúrate de que 'context' esté disponible
//
//        return userCredential;
//      } else {
//        return null;
//      }
//    }
//  } catch (error) {
//    //Mostrar error si no se puede iniciar sesion con twitter
//    print('Error al iniciar sesión con Twitter: $error');
//  }
//  return null;
//}
//
//