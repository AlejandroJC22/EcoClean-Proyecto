import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/controller/add_data.dart';
import 'package:flutter_ecoclean/models/inputs.dart';
import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/views/favoritos.dart';
import 'package:flutter_ecoclean/views/login.dart';
import 'package:image_picker/image_picker.dart';

import '../utilidades/responsive.dart';
import '../views/forgot_password.dart';

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
              child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
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

                    try {
                      if (field == 'Nombre') {
                        await userRef.update({'nombre': newValue});
                      } else if (field == 'Correo') {
                        await userRef.update({'correo': newValue});
                      } else if (field == "Casa"){
                        await userRef.update({'direccion_casa': newValue});
                      }else if (field == "Trabajo"){
                        await userRef.update({'direccion_trabajo': newValue});
                      }

                      // Mostrar Snackbar si la actualización fue exitosa
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Datos actualizados correctamente'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      // Mostrar Snackbar si la actualización falla
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No se pudo actualizar los datos'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }

                  Navigator.of(context).pop();
                }
              },
              child: const Text('Actualizar', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  //Ventana para editar contraseña
  static void editPassword(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cambiar contraseña'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Inputs(
                  controller: currentPasswordController,
                  labelText: "Contraseña Actual",
                  obscureText: true,
                ),
                Inputs(
                  controller: newPasswordController,
                  labelText: "Nueva contraseña",
                  obscureText: false,
                ),
                Inputs(
                  controller: confirmPasswordController,
                  labelText: "Confirmar nueva contraseña",
                  obscureText: true,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPass()));
                  },
                  child: Text('Olvidé mi contraseña', style: TextStyles.preguntas(responsive)),
                ),
              ],
            ),
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
                String currentPassword = currentPasswordController.text;
                String newPassword = newPasswordController.text;
                String confirmPassword = confirmPasswordController.text;

                if (currentPassword.isNotEmpty &&
                    newPassword.isNotEmpty &&
                    confirmPassword.isNotEmpty) {
                  if (newPassword == confirmPassword) {
                    try {
                      // Cambiar la contraseña
                      User? user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        AuthCredential credential = EmailAuthProvider.credential(
                          email: user.email!,
                          password: currentPassword,
                        );

                        await user.reauthenticateWithCredential(credential);
                        await user.updatePassword(newPassword);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Contraseña cambiada exitosamente.'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Usuario no autenticado.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Error al cambiar la contraseña. Verifica la contraseña actual.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }

                    Navigator.of(context).pop();
                  } else {
                    // Mostrar un mensaje de error si las contraseñas no coinciden
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Las contraseñas no coinciden.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } else {
                  // Mostrar un mensaje de error si algún campo está vacío
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Completa todos los campos.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Actualizar', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  //Ventana para seleccionar metodo de cambio de imagen
  static void showOptions(BuildContext context, Function(ImageSource) onSelect) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Seleccionar imagen desde:'),
          actions: [
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                onSelect(ImageSource.gallery); // Ir a la galería
              },
              leading: Icon(Icons.photo),
              title: Text('Galería'),
            ),

            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                onSelect(ImageSource.camera); // Usar la cámara
              },
              leading: Icon(Icons.camera_alt),
              title: Text('Cámara'),
            ),

            ListTile(
              onTap: () {
                Navigator.of(context).pop(); // Cancelar
              },
              leading: Icon(Icons.cancel, color: Colors.red),
              title: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  static void deleteAccount(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmación"),
          content: const Text("¿Estás seguro de que quieres eliminar todos los datos?\n Esta acción es irreversible"),
          actions: [
            TextButton(
              child: const Text("Cancelar", style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
            ),
            TextButton(
              child: const Text("Aceptar", style: TextStyle(color: Colors.red),),
              onPressed: () async {
                // Crear una instancia de StoreData
                StoreData storeData = StoreData();

                // Llamar al método deleteData en la instancia creada
                await storeData.deleteData(id);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                // Puedes redirigir a la pantalla de inicio de sesión después de eliminar los datos
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  static void location(BuildContext context, String address, Function(String) onLocationTypeSelected) async {
    TextEditingController addressController = TextEditingController(text: address);

    String locationType = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detalles de la ubicación'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: addressController,
                ),
                const SizedBox(height: 10),
                const Text('¿Dónde estás ahora?'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, 'Casa');
                      },
                      child: Text('Casa'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, 'Trabajo');
                      },
                      child: Text('Trabajo'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );

    if (addressController.text.isNotEmpty) {
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid != null) {
        String collectionName = 'users';
        String documentName = uid; // Use the UID as the document name

        // Update the specific document for the user
        FirebaseFirestore.instance.collection(collectionName).doc(documentName).update({
          locationType == 'Casa' ? 'direccion_casa' : 'direccion_trabajo': addressController.text,
        });
      }
    }

    onLocationTypeSelected(locationType);
  }

  static void confirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmación"),
          content: const Text("¿Estás seguro de que quieres eliminar las rutas?"),
          actions: [
            TextButton(
              child: const Text("Cancelar", style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
            ),
            TextButton(
              child: const Text("Aceptar", style: TextStyle(color: Colors.red)),
              onPressed: () async {
                // Obtener el UID del usuario autenticado
                String uid = FirebaseAuth.instance.currentUser!.uid;

                // Actualizar las rutas en la base de datos
                try {
                  // Actualizar las rutas en tu base de datos, por ejemplo, usando Firebase Firestore
                  await FirebaseFirestore.instance.collection('users').doc(uid).update({
                    'direccion_casa': '',
                    'direccion_trabajo': '',
                  });

                  print('Rutas eliminadas correctamente.');
                } catch (e) {
                  print('Error al eliminar las rutas: $e');
                }

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Rutas eliminadas correctamente.'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

}


