import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/controller/dialogHelper.dart';
import 'package:flutter_ecoclean/views/login.dart';

import '../models/inputs.dart';
import '../models/texto.dart';
import '../utilidades/responsive.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass ({Key? key}) : super (key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass>{
  TextEditingController emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  Future<void> PasswordReset() async {
    try {
      final email = emailController.text.trim();
      final userExists = await doesEmailExistInFirestore(email);

      if (userExists) {
        // El correo está registrado en Firestore, puedes enviar el correo de restablecimiento
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        DialogHelper.showAlertDialogRegister(
          context,
          "Correo enviado",
          "Se ha enviado un correo electrónico con el enlace de recuperación de contraseña",
        );
      } else {
        // El correo no está registrado en Firestore
        DialogHelper.showAlertDialog(
          context,
          "Datos erróneos",
          "El correo ingresado no se encuentra registrado en nuestra base de datos, por favor verifique el correo",
        );
      }
    } on FirebaseAuthException catch (e) {
      // Manejo de errores de Firebase Authentication
      if (e.code == 'invalid-email') {
        DialogHelper.showAlertDialog(context, "Correo inválido", "Por favor ingrese un correo válido.");
      } else {
        DialogHelper.showAlertDialog(context, "Datos erróneos", "Por favor ingrese el correo para recuperar contraseña");
      }
    }
  }

  Future<bool> doesEmailExistInFirestore(String email) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('correo', isEqualTo: email)
        .limit(1)
        .get();

    return result.docs.isNotEmpty;
  }


  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Navegar a la pantalla de inicio de sesión aquí
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text("Cancelar", style: TextStyles.enlaces(responsive)),
              ),
              SizedBox(width: 80),
              Image.asset("lib/iconos/logoApp.png", width: 32, height: 32),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Encuentra tu cuenta",
                style: TextStyles.tituloNegro(responsive)),
              ),
              const SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Introduce el correo electrónico asociado a tu cuenta para cambiar tu contraseña",
                style: TextStyles.textoSinNegrita(responsive)),
              ),
              const SizedBox(height: 15),
              Inputs(
                  controller: emailController,
                  labelText: "Correo electronico",
                  obscureText: false
              ),
              Container(
                margin: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width - 30,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text("Restablecer contraseña", style: TextStyle(fontSize: responsive.ip(5), color: Colors.white)),
                  onPressed: PasswordReset,
                ),),
            ],
          ),
        ),
      )

    );
  }

}