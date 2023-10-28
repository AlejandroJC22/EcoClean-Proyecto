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

Future<UserCredential?> signInWithGoogle(BuildContext context) async {
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
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // Mostrar la pantalla de menú.
    showMenuScreen(context);

    return userCredential;


  } catch (error) {
    // Manejar errores, por ejemplo, mostrar un mensaje al usuario.
    print('Error al iniciar sesión con Google: $error');
    return null;
  }
}

