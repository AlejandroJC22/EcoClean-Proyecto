import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

        final UserCredential userCredential =
        await _auth.signInWithCredential(facebookAuthCredential);

        return userCredential.user;
      } else {
        return null;
      }
    } catch (e) {
      print('Error en la autenticación con Facebook: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
