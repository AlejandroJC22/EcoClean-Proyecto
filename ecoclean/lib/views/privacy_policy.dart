import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/views/terms_and_conditions.dart';

// Página que muestra la Política de Privacidad de la aplicación EcoClean Bogotá.
class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    // Instancia de la clase Responsive para gestionar la responsividad del diseño.
    final Responsive responsive = Responsive.of(context);
    // Retornar la estructura de la página con la Política de Privacidad.
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
            _buildSectionTitle("Politica de Privacidad de EcoClean Bogotá", responsive),

            // Información sobre la última actualización.
            _buildSectionText("Ultima actualización: 11/12/2023", responsive),

            const SizedBox(height: 40,),

            // Texto inicial de la Política de Privacidad.
            _buildSectionText(
              "Bienvenido a EcoClean Bogotá. Tu privacidad es importante para nosotros. Esta política de privacidad explica cómo recopilamos, utilizamos, compartimos y protegemos tu información personal al utilizar nuestra aplicación.",
              responsive,
            ),
            const SizedBox(height: 40,),

            // Sección 1
            _buildSectionSubtitle("1. Información Recopilada", responsive),
            _buildSectionText(
              "Al registrarte o utilizar nuestra aplicación, podemos recopilar información personal como tu nombre, dirección de correo electrónico y datos de contacto. Esta información se utiliza para personalizar tu experiencia y mejorar nuestros servicios.",
              responsive,
            ),
            // Subsecciones
            ExpansionTile(
              title: Text("1.1  Datos de Localización", style: TextStyles.subtitulos(responsive)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'La aplicación utiliza servicios de localización para proporcionar información sobre rutas de recolección de los vehículos de recolección de basuras de la ciudad.',
                    style: TextStyles.textoSinNegrita(responsive),
                  ),
                ),
              ]
            ),
            // Subsecciones
            ExpansionTile(
                title: Text("1.2  Datos del ChatBot", style: TextStyles.subtitulos(responsive)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Las interacciones con el ChatBot no son almacenadas, puesto que pueden manejar información sensible de estas conversaciones.',
                      style: TextStyles.textoSinNegrita(responsive),
                    ),
                  ),
                ]
            ),
            const SizedBox(height: 40,),

            //Sección 2
            _buildSectionSubtitle("2. Uso de la Información", responsive),
            _buildSectionText("La informacion que recopilamos cuando usas EcoClean se divide en la siguiente categoría.", responsive),
            // Subsecciones
            ExpansionTile(
                title: Text("2.1  Comunicaciones", style: TextStyles.subtitulos(responsive)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Podemos utilizar tu información para enviarte notificaciones importantes sobre cambios en la aplicación, actualizaciones de servicios o eventos relevantes.',
                      style: TextStyles.textoSinNegrita(responsive),
                    ),
                  ),
                ]
            ),
            const SizedBox(height: 40,),

            //Sección 3
            _buildSectionSubtitle("3. Seguridad", responsive),
            _buildSectionText("Las medidas de seguridad usadas en EcoClean para proteger tus datos se encuentran en la siguiente sección.", responsive),
            // Subsecciones
            ExpansionTile(
                title: Text("3.1  Medidas de Seguridad", style: TextStyles.subtitulos(responsive)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Implementamos medidas de seguridad para proteger tu información contra el acceso no autorizado, la alteración, la divulgación o la destrucción no autorizada.',
                      style: TextStyles.textoSinNegrita(responsive),
                    ),
                  ),
                ]
            ),
            const SizedBox(height: 40,),

            //Sección 4
            _buildSectionSubtitle("4. Derechos del Usuario", responsive),
            _buildSectionText("Para nosotros es importante mantener la transparencia y garantizar tus derechos. Tus derechos como usuario de EcoClean Bogotá se dividen en dos secciones:", responsive),
            // Subsecciones
            ExpansionTile(
                title: Text("4.1  Acceso y Modificación", style: TextStyles.subtitulos(responsive)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Puedes acceder y modificar tu información personal en la sección de perfil de la aplicación.',
                      style: TextStyles.textoSinNegrita(responsive),
                    ),
                  ),
                ]
            ),
            // Subsecciones
            ExpansionTile(
                title: Text("4.2  Eliminación de Datos", style: TextStyles.subtitulos(responsive)),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Si deseas eliminar tu cuenta y la información asociada, puedes hacerlo a través de la configuración de la aplicación.',
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
                  padding: const EdgeInsets.all(16.0),
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
                        'Queremos escuchar tus preguntas o comentarios sobre nuestra Politica de Privacidad. Por lo tanto, puedes contactarte con nosotros mediante el correo electrónico ',
                        style: TextStyles.textoSinNegrita(responsive),
                        children: const [
                          //Subrayar el correo
                          TextSpan(
                            text: 'ecoclean400@gmail.com',
                            style: TextStyle(
                              color: Colors.green,
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
            _buildSectionText("Gracias por confiar en EcoClean Bogotá para tus necesidades de gestión de residuos. ¡Juntos hacemos la diferencia!", responsive),
            const SizedBox(height: 10,),

            //Derechos de autor
            _buildSectionSubtitle("© 2023 EcoClean Corp", responsive),

            //Permitir ir a terminos y condiciones
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(left: 15,),
                child: Text(
                  "Terminos y Condiciones",
                  style: TextStyles.subtitulos(responsive),
                ),
              ),
              //Al pulsar, redirigir a terminos y condiciones
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const TermsAndConditions()));
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
      margin: const EdgeInsets.only(left: 15, right: 15),
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
      margin: const EdgeInsets.only(left: 15),
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