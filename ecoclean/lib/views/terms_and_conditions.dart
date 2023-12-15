import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/views/privacy_policy.dart';

// Página que muestra los Terminos y Condiciones de la aplicación EcoClean Bogotá.
class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    // Instancia de la clase Responsive para gestionar la responsividad del diseño.
    final Responsive responsive = Responsive.of(context);

    // Retornar la estructura de la página con los Terminos y Condiciones.
    return Scaffold(
      appBar: AppBar(
        // Barra de aplicación con título y botón de retorno.
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("lib/iconos/logoApp.png", width: 32, height: 32),
          ],
        ),
        // Botón de retorno que cierra la pantalla actual.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green,),
          onPressed: () {
            Navigator.of(context).pop(); // Regresa a la pantalla anterior
          },
        ),
      ),
      body: SingleChildScrollView(
        // Widget de desplazamiento vertical para permitir la visualización del contenido.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sección de título principal.
            _buildSectionTitle("Términos del Servicio de EcoClean Bogotá", responsive),

            // Información sobre la última actualización.
            _buildSectionText("Ultima actualización: 11/12/2023", responsive),
            const SizedBox(height: 40,),

            // Texto inicial de los Terminos y Condiciones.
            _buildSectionText(
              "Bienvenido a EcoClean Bogotá. Estos Términos del Servicio rigen el uso de nuestra aplicación. Al acceder o utilizar EcoClean Bogotá, aceptas estos términos.",
              responsive,
            ),
            const SizedBox(height: 40,),

            //Sección 1
            _buildSectionSubtitle("1. Uso de la Aplicación", responsive),
            _buildSectionText(
              "La aplicación se destina a facilitar la gestión eficiente de residuos sólidos en la ciudad, para su uso hemos dividido esta sección en dos partes.",
              responsive,
            ),
            // Subsecciones
            ExpansionTile(
                title: Text("1.1  Licencia de Uso", style: TextStyles.subtitulos(responsive)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Te concedemos una licencia limitada, no exclusiva y no transferible para utilizar EcoClean Bogotá con fines personales y no comerciales.',
                      style: TextStyles.textoSinNegrita(responsive),
                    ),
                  ),
                ]
            ),
            // Subsecciones
            ExpansionTile(
                title: Text("1.2  Requisitos del usuario", style: TextStyles.subtitulos(responsive)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Debes ser mayor de edad o contar con el consentimiento de un padre o tutor para utilizar la aplicación. Te comprometes a proporcionar información precisa y mantener tu cuenta segura.',
                      style: TextStyles.textoSinNegrita(responsive),
                    ),
                  ),
                ]
            ),
            const SizedBox(height: 40,),

            //Sección 2
            _buildSectionSubtitle("2. Contenido y Propiedad Intelectual", responsive),
            _buildSectionText("En EcoClean Bogotá, valoramos la propiedad intelectual y el contenido generado. Esta sección se centra en la protección y el respeto de los derechos relacionados con el contenido de la aplicación y se divide en dos aspectos clave.", responsive),
            ExpansionTile(
                title: Text("2.1  Derechos de Autor", style: TextStyles.subtitulos(responsive)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Todos los derechos de autor, marcas comerciales y otros derechos de propiedad intelectual relacionados con EcoClean Bogotá son propiedad nuestra o de nuestros licenciantes.',
                      style: TextStyles.textoSinNegrita(responsive),
                    ),
                  ),
                ]
            ),
            // Subsecciones
            ExpansionTile(
                title: Text("2.2  Uso Adecuado", style: TextStyles.subtitulos(responsive)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'No debes copiar, reproducir, distribuir, transmitir, mostrar, vender, licenciar ni explotar de ninguna otra manera el contenido de EcoClean Bogotá sin nuestro consentimiento.',
                      style: TextStyles.textoSinNegrita(responsive),
                    ),
                  ),
                ]
            ),
            const SizedBox(height: 40,),

            //Sección 3
            _buildSectionSubtitle("3. Responsabilidades y Limitaciones", responsive),
            _buildSectionText("Asumimos compromisos y establecemos límites para garantizar una experiencia segura y respetuosa para todos los usuarios. Esta sección aborda nuestras responsabilidades y las limitaciones que aplican, dividiéndose en dos áreas fundamentales.", responsive),
            // Subsecciones
            ExpansionTile(
                title: Text("3.1  Uso Adecuado", style: TextStyles.subtitulos(responsive)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Te comprometes a utilizar la aplicación de manera ética y legal. No debes realizar actividades que puedan dañar, deshabilitar o sobrecargar la aplicación.',
                      style: TextStyles.textoSinNegrita(responsive),
                    ),
                  ),
                ]
            ),
            // Subsecciones
            ExpansionTile(
                title: Text("3.2  Limitación de Responsabilidad", style: TextStyles.subtitulos(responsive)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'No somos responsables de los daños directos, indirectos, incidentales, especiales o consecuentes que puedan surgir del uso de EcoClean Bogotá.',
                      style: TextStyles.textoSinNegrita(responsive),
                    ),
                  ),
                ]
            ),
            const SizedBox(height: 40,),

            //Sección 4
            _buildSectionSubtitle("4. Término y Terminación", responsive),
            _buildSectionText("Establecemos las condiciones para la finalización de tu relación con la aplicación. Abarcamos los términos de uso y los escenarios que pueden llevar a la terminación, proporcionando una guía clara y única para la conclusión de nuestra asociación.", responsive),
            // Subsecciones
            ExpansionTile(
                title: Text("4.1  Terminación", style: TextStyles.subtitulos(responsive)),
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Podemos terminar o suspender tu acceso a EcoClean Bogotá en cualquier momento, sin previo aviso, si violas estos Términos del Servicio.',
                      style: TextStyles.textoSinNegrita(responsive),
                    ),
                  ),
                ]
            ),
            const SizedBox(height: 40,),

            // Subsección 5 información de contacto
            ExpansionTile(
              title:  Text(
                  "5. Cómo contactar con EcoClean",
                  style: TextStyles.subtitulos(responsive),
                ),
              //permitir la copia del correo electronico
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  //Obtener la información al pulsar la pantalla
                  child: GestureDetector(
                    onTap: () {
                      //Si se toca el correo que lo cpie al portapapeles
                      const String email = 'ecoclean400@gmail.com';
                      Clipboard.setData(const ClipboardData(text: email));
                      //Mostrar confirmación de copiado de información
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Correo electrónico copiado al portapapeles'),
                      ));
                    },
                    //Texto subsección 5
                    child: RichText(
                      text: TextSpan(
                        text:
                        'Queremos escuchar tus preguntas o comentarios sobre nuestros Términos y Condiciones. Por lo tanto, puedes contactarte con nosotros mediante el correo electrónico ',
                        style: TextStyles.textoSinNegrita(responsive),
                        children: const [
                          //Subrayar el correo
                          TextSpan(
                            text: 'ecoclean400@gmail.com',
                            style: TextStyle(
                              color: Colors.blue, // Puedes cambiar el color según tus preferencias
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            //Texto final
            _buildSectionText("¡Gracias por elegir EcoClean Bogotá!", responsive),
            const SizedBox(height: 10,),

            //Derechos de autor
            _buildSectionSubtitle("© 2023 EcoClean Corp", responsive),

            //Permitir ir a terminos y condiciones
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 15,),
                child: Text(
                  "Política de Privacidad",
                  style: TextStyles.subtitulos(responsive),
                ),
              ),
              //Al pulsar, redirigir a terminos y condiciones
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
              },
            ),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }

  //Widget para construir el titulo
  Widget _buildSectionTitle(String title, Responsive responsive) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyles.tituloNegro(responsive),
      ),
    );
  }

  //Widget para construir subtitulos
  Widget _buildSectionSubtitle(String title, Responsive responsive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      margin: EdgeInsets.only(left: 15),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyles.subtitulos(responsive),
      ),
    );
  }

  //Widget para construir textos
  Widget _buildSectionText(String text, Responsive responsive) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyles.textoSinNegrita(responsive),
      ),
    );
  }
}
