import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/views/privacy_policy.dart';
import 'package:flutter_ecoclean/views/terms_and_conditions.dart';

// Clase que proporciona un contenedor con texto enriquecido que incluye enlaces a los Términos y la Política de Privacidad.
class TextAndPrivacy {
  // Método para obtener un contenedor con texto enriquecido.
  static Container getRichText(BuildContext context) {
    // Instancia de la clase Responsive para gestionar la responsividad del diseño.
    final Responsive responsive = Responsive.of(context);

    // Retornar un contenedor con texto enriquecido.
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 10, top: 15),
      child: RichText(
        // Configurar el texto enriquecido con varios fragmentos y estilos.
        text: TextSpan(
          // Texto principal
          text: '*Al registrarte, aceptas nuestros ',
          style: TextStyles.textoSinNegrita(responsive),
          // Lista de fragmentos de texto con estilos y acciones específicas.
          children: <TextSpan>[
            // Fragmento de texto con enlace a los Términos y condiciones.
            TextSpan(
              text: 'Términos',
              style: const TextStyle(
                color: Colors.green,
                decoration: TextDecoration.underline,
              ),
              // Configurar acción al hacer clic en el enlace.
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Navegar a la pantalla de Términos y Condiciones al hacer clic.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TermsAndConditions()),
                  );
                },
            ),
            // Fragmento de texto adicional
            const TextSpan(
              text: ' y nuestra ',
            ),
            // Fragmento de texto con enlace a la Política de Privacidad.
            TextSpan(
              text: 'Política de Privacidad',
              style: const TextStyle(
                color: Colors.green,
                decoration: TextDecoration.underline,
              ),
              // Configurar acción al hacer clic en el enlace.
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Navegar a la pantalla de Política de Privacidad al hacer clic.
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PrivacyPolicy()),
                  );
                },
            ),
            // Fragmento de texto adicional
            const TextSpan(
              text: ' del servicio.',
            ),
          ],
        ),
      ),
    );
  }
}

