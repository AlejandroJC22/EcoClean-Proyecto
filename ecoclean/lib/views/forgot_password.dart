import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/controller/dialogHelper.dart';
import '../models/inputs.dart';
import '../models/texto.dart';
import '../utilidades/responsive.dart';


class ForgotPass extends StatefulWidget {
  const ForgotPass ({Key? key}) : super (key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

//Vista olvido de contraseña
class _ForgotPassState extends State<ForgotPass>{
  //Variable contenedora de correo electronico
  TextEditingController emailController = TextEditingController();

  //Inicializador de procesos
  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  //Conexión con la base de datos
  Future<void> PasswordReset() async {
    try {
      //Buscar el correo ingresado en la base de datos
      final email = emailController.text.trim();
      final userExists = await doesEmailExistInFirestore(email);

      if (userExists) {
        // El correo está registrado en Firestore, puedes enviar el correo de restablecimiento
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        //Mostrar información sobre recuperación de contraseña
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

  //Booleano identificador de correo ingresado
  Future<bool> doesEmailExistInFirestore(String email) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
    //Buscar en la colección users, que sea igual al correo de la base de datos, un correo unico
        .collection('users')
        .where('correo', isEqualTo: email)
        .limit(1)
        .get();

    //Retornar la información
    return result.docs.isNotEmpty;
  }

  //Construir la vista
  @override
  Widget build(BuildContext context) {
    //Obtener la diagonal del dispositivo
    final Responsive responsive = Responsive.of(context);
    return SafeArea(
      //Construccion de la ventana forgot_password
      child: Scaffold(
        //AppBar
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // Navegar a la pantalla de inicio de sesión aquí
                  Navigator.of(context).pop();
                },
                //texto identificador
                child: Text("Cancelar", style: TextStyles.enlaces(responsive)),
              ),
              //Espaciado entre campos
              SizedBox(width: 80),
              //Icono de la aplicación
              Image.asset("lib/iconos/logoApp.png", width: 32, height: 32),
            ],
          ),
        ),
        //Cuerpo de la ventana
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              //Titulo inicial
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Encuentra tu cuenta",
                style: TextStyles.tituloNegro(responsive)),
              ),
              //Espaciado entre campos
              const SizedBox(height: 20),
              //Texto informativo
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Introduce el correo electrónico asociado a tu cuenta para cambiar tu contraseña",
                style: TextStyles.textoSinNegrita(responsive)),
              ),
              //Espaciado entre campos
              const SizedBox(height: 15),
              //Espacio de ingreso de texto
              Inputs(
                //Almacenamiento y diseño de datos
                  controller: emailController,
                  labelText: "Correo electronico",
                  obscureText: false
              ),
              //Container boton
              Container(
                //Alineación y tamaño
                margin: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width - 30,
                height: 50,
                //Texto del boton
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text("Restablecer contraseña", style: TextStyle(fontSize: responsive.ip(5), color: Colors.white)),
                  //Logica al oprimir el boton
                  onPressed: PasswordReset,
                ),),
            ],
          ),
        ),
      )

    );
  }

}