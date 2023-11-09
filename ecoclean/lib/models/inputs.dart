import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/models/texto.dart';

import '../utilidades/responsive.dart';

//Clase para definir diseño en inputs del proyecto
class Inputs extends StatelessWidget {
  //Definimos variables y controladores
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  //Controlamos los datos ingresados por el usuario
  Inputs({
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    //Llamamos la clase del tamaño de pantalla
    final Responsive responsive = Responsive.of(context);
    //Construimos la vista
    return Positioned(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextFormField(
              //Llamamos al controlador para almacenar los datos ingresados
              controller: controller,
              //Si es contraseña ocultamos el texto
              obscureText: obscureText,
              decoration: InputDecoration(
                //Decoracion del input
                labelText: labelText,
                labelStyle: TextStyles.enlaces(responsive)
              ),
              style: TextStyles.textoSinNegrita(responsive)
              ),
            ),
          ],
        ),
      );
    }
}
