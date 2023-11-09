import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/views/login.dart';

// Clase que nos va a mostrar ventanas de dialogo
class DialogHelper {
  static void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // No cerrar la pantalla actual, solo el AlertDialog
              },
              child: const Text("Aceptar", style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  //Clase ventana de dialogo al registrar un nuevo usuario por correo electronico
  static void showAlertDialogRegister(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Cerrar la ventana actual al ser registro exitoso
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
              },
              child: const Text("Aceptar", style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  //Clase ventana de dialogo para editar nombre y correo
  static void editProfile(BuildContext context, String field, String initialValue, Function(String) onEdit) {
    String? newValue;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar $field'),
          content: TextFormField(
            initialValue: initialValue,
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Cancelar la edición
                Navigator.of(context).pop();
              },
              child: Text('Cancelar', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () async {
                // Actualizar el campo
                if (newValue != null && newValue!.isNotEmpty) {
                  onEdit(newValue!);

                  // Actualizar el campo correspondiente en Firestore
                  final user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    final userId = user.uid;

                    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

                    if (field == 'Nombre') {
                      await userRef.update({'nombre': newValue});
                    } else if (field == 'Correo') {
                      await userRef.update({'correo': newValue});
                    }
                  }

                  Navigator.of(context).pop();
                }
              },
              child: Text('Actualizar', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

}


