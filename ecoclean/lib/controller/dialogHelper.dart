import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/views/login.dart';

// Clase que nos va a mostrar ventanas de dialogo
class DialogHelper {
  static void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // No cerrar la pantalla actual, solo el AlertDialog
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }
  static void showAlertDialogRegister(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // No cerrar la pantalla actual, solo el AlertDialog
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }
}


