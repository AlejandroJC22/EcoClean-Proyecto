import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['public_profile', 'email']);

    if (loginResult.status == LoginStatus.success) {
      try {
        final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

        final userData = await FacebookAuth.i.getUserData(fields: "name,email,picture.width(200)");

        final UserCredential userCredential =
        await _auth.signInWithCredential(facebookAuthCredential);
        final User? user = userCredential.user;

        final userRef = _firestore.collection('users').doc(user!.uid);

        // Crear un mapa con los datos que deseas almacenar
        final userDataMap = {
          'correo': userData['email'],
          'nombre': userData['name'],
          'imagenURL': userCredential.user!.photoURL,
          'provider': "Facebook",
          'uid': user.uid
        };

        // Utiliza el método set para crear un nuevo documento en Firestore o actualizar uno existente
        await userRef.set(userDataMap, SetOptions(merge: true));

        return user;
      } catch (e) {
        print('Error en la autenticación con Facebook: $e');
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
