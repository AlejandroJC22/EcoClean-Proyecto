import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImage(String childName, String userId, Uint8List file) async {
    Reference ref = _storage.ref().child(childName).child(userId);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String urlImage = await snapshot.ref.getDownloadURL();
    return urlImage;
  }

  Future<void> saveData({required Uint8List file, required String userId}) async {
    try {
      String imageUrl = await uploadImage('profileImages', userId, file);

      // Obtiene una referencia al documento del usuario
      final DocumentReference userRef = _firestore.collection('users').doc(userId);

      if (imageUrl.isNotEmpty) {
        // Actualiza el campo "imagenURL" con la nueva URL de descarga
        await userRef.update({'imagenURL': imageUrl});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteData(String userId) async {
    try {
      // Obtener el usuario actual
      User? user = FirebaseAuth.instance.currentUser;

      // Verificar si el usuario actual es nulo (no debería serlo si ha iniciado sesión)
      if (user != null) {
        // Eliminar datos de FirebaseAuth (cerrar sesión y eliminar la cuenta permanentemente)
        await user.delete();
      }

      // Eliminar datos de FirebaseFirestore
      await _firestore.collection('users').doc(userId).delete();

      // Eliminar datos de FirebaseStorage
      await _storage.ref().child('profileImages').child(userId).delete();

      // Mostrar un mensaje de éxito o realizar otras acciones después de eliminar los datos
      print("Datos eliminados con éxito.");
    } catch (error) {
      print("Error al eliminar datos: $error");
      // Mostrar un mensaje de error o realizar otras acciones en caso de error
    }
  }
}
