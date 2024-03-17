import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter/material.dart';


//Colores usados en la aplicacion
class AppColors {
  static const Color inicial = Colors.green;
  static const Color texto = Colors.black;
  static const Color preguntas = Colors.grey;
  static const Color salidas = Colors.red;
}
//Letra de la aplicacion
class AppFonts {
  static const String fontFamily = 'Impact';
}
//Estilos de letra
class TextStyles {
  //Estilo para titulos en negrita de color negro
  static TextStyle tituloNegro(Responsive responsive) {
    return TextStyle(
      color: AppColors.texto,
      fontWeight: FontWeight.bold,
      fontSize: responsive.ip(5),
      fontFamily: AppFonts.fontFamily,
    );
  }
  //Estilo para subtitulos en negrita de color negro
  static TextStyle subtitulos(Responsive responsive) {
    return TextStyle(
      color: AppColors.texto,
      fontWeight: FontWeight.bold,
      fontSize: responsive.ip(4),
      fontFamily: AppFonts.fontFamily,
    );
  }
  //Estilo para textos de color negro sin negrita
  static TextStyle textoSinNegrita(Responsive responsive) {
    return TextStyle(
      color: AppColors.texto,
      fontSize: responsive.ip(4),
      fontFamily: AppFonts.fontFamily,
    );
  }
  //Estilo para preguntas de color gris
  static TextStyle preguntas(Responsive responsive) {
    return TextStyle(
      color: AppColors.preguntas,
      fontWeight: FontWeight.bold,
      fontSize: responsive.ip(4),
      fontFamily: AppFonts.fontFamily,
    );
  }
  //Estilo para enlaces o botones de color verde
  static TextStyle enlaces(Responsive responsive) {
    return TextStyle(
      color: AppColors.inicial,
      fontWeight: FontWeight.bold,
      fontSize: responsive.ip(4),
      fontFamily: AppFonts.fontFamily,
    );
  }
  //Estilo para cerrar sesión o eliminar cuenta de color rojo
  static TextStyle salidas(Responsive responsive) {
    return TextStyle(
      color: AppColors.salidas,
      fontWeight: FontWeight.bold,
      fontSize: responsive.ip(4),
      fontFamily: AppFonts.fontFamily,
    );
  }

}


