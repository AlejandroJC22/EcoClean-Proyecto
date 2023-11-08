import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter/material.dart';

class AppColors {

  static const Color titulo = Colors.green;
  static const Color texto = Colors.black;
  static const Color preguntas = Colors.grey;
  static const Color enlaces = Colors.green;
  static const Color salidas = Colors.red;
  static const Color botonChat = Colors.black;
  static const Color iconoBoton = Colors.white;
}

class AppFonts {
  static const String fontFamily = 'Impact';
}

class TextStyles {
  static TextStyle tituloInicial(Responsive responsive) {
    return TextStyle(
      color: AppColors.titulo,
      fontWeight: FontWeight.bold,
      fontSize: responsive.ip(10),
      fontFamily: AppFonts.fontFamily,
    );
  }
  static TextStyle tituloNegro(Responsive responsive) {
    return TextStyle(
      color: AppColors.texto,
      fontWeight: FontWeight.bold,
      fontSize: responsive.ip(5),
      fontFamily: AppFonts.fontFamily,
    );
  }

  static TextStyle textoNegro(Responsive responsive) {
    return TextStyle(
      color: AppColors.texto,
      fontWeight: FontWeight.bold,
      fontSize: responsive.ip(4),
      fontFamily: AppFonts.fontFamily,
    );
  }
  static TextStyle textoSinNegrita(Responsive responsive) {
    return TextStyle(
      color: AppColors.texto,
      fontSize: responsive.ip(4),
      fontFamily: AppFonts.fontFamily,
    );
  }
  static TextStyle preguntas(Responsive responsive) {
    return TextStyle(
      color: AppColors.preguntas,
      fontWeight: FontWeight.bold,
      fontSize: responsive.ip(4),
      fontFamily: AppFonts.fontFamily,
    );
  }
  static TextStyle enlaces(Responsive responsive) {
    return TextStyle(
      color: AppColors.enlaces,
      fontWeight: FontWeight.bold,
      fontSize: responsive.ip(4),
      fontFamily: AppFonts.fontFamily,
    );

  }
  static TextStyle salidas(Responsive responsive) {
    return TextStyle(
      color: AppColors.enlaces,
      fontWeight: FontWeight.bold,
      fontSize: responsive.ip(4),
      fontFamily: AppFonts.fontFamily,
    );
  }

}
class inputs {
  static TextStyle inputsRed(){
    return const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 18
    );
  }
  static TextStyle inputsBlack(){
    return const TextStyle(
      color: Colors.black,
      fontSize: 18,
    );
  }
}

