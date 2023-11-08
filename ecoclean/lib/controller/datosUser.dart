import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//
class DatosUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _pruebaCollection = FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>> getUserData() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      // Asegúrate de que el usuario actual esté autenticado
      await user.reload();
      final updatedUser = _auth.currentUser;

      if (updatedUser != null) {
        final QuerySnapshot userSnapshot = await _pruebaCollection.where('uid', isEqualTo: updatedUser.uid).get();

        if (userSnapshot.docs.isNotEmpty) {
          final userData = userSnapshot.docs.first.data() as Map<String, dynamic>;

          // Comprueba si el usuario ha iniciado sesión con Google
          if (updatedUser.providerData.any((userInfo) => userInfo.providerId == 'google.com')) {
            userData['nombre'] = updatedUser.displayName ?? userData['nombre'];
            userData['correo'] = updatedUser.email ?? userData['correo'];
            userData['imagen'] = updatedUser.photoURL ?? userData['imagen'];
          }

          // Comprueba si el usuario ha iniciado sesión con Twitter
          if (updatedUser.providerData.any((userInfo) => userInfo.providerId == 'twitter.com')) {
            // Aquí puedes manejar los datos específicos de Twitter
            // Por ejemplo, si Twitter proporciona un nombre de usuario, puedes acceder a él
            // userInfo.username o similar
          }

          return {
            'correo': userData['correo'],
            'imagen': userData['imagen'],
            'nombre': userData['nombre'],
          };
        }
      }
    }

    return <String, dynamic>{};
  }
}
