import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecoclean/models/inputs.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void _showAlertDialog(String title, String message) {
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
                Navigator.of(context).pop();
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }


  Future<void> _registerUser() async {
    final String username = usernameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showAlertDialog("Registro Fallido", "Por favor, ingresa todos los datos.");
      return;
    }

    if (password != confirmPassword) {
      _showAlertDialog("Registro Fallido", "Las contraseñas no coinciden");
    } else {
      try {
        final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final User? user = userCredential.user;

        if (user != null) {
          _showAlertDialog("Registro Exitoso", "Se ha completado el registro, por favor inicie sesión.");
        } else {
          _showAlertDialog("Registro Fallido", "No se pudo obtener el UID del usuario.");
        }
      } catch (error) {
        _showAlertDialog("Error al registrar", "Error: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: const Text(
                  "Registrarse",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Inputs(
                controller: usernameController,
                labelText: "Nombre de usuario",
                obscureText: false,
              ),
              const SizedBox(height: 15),
              Inputs(
                controller: emailController,
                labelText: "Correo electrónico",
                obscureText: false,
              ),
              const SizedBox(height: 15),
              Inputs(
                controller: passwordController,
                labelText: "Contraseña",
                obscureText: true,
              ),
              const SizedBox(height: 15),
              Inputs(
                controller: confirmPasswordController,
                labelText: "Confirmar contraseña",
                obscureText: true,
              ),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.all(15),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: _registerUser,
                  child: Text(
                    "Registrarse",
                    style: TextStyle(fontSize: responsive.ip(5), color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "¿Tienes una cuenta? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      child: const Text(
                        "Iniciar Sesión",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
