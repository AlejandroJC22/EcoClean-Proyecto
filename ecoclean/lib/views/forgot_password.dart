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

  Future PasswordReset() async {
  try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());

    DialogHelper.showAlertDialogRegister(context,"Correo enviado", "Se ha enviado un correo electronico con el link de recuperación de contraseña");

  }on FirebaseAuthException catch (e){
    DialogHelper.showAlertDialogRegister(context,"Datos erroneos", "El correo ingresado no se encuentra registrado, por favor verifique el correo");
  }
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