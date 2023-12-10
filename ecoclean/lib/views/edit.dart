import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/controller/dialogHelper.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/views/editProfile/add_data.dart';
import 'package:flutter_ecoclean/views/editProfile/edit_profile.dart';
import 'package:image_picker/image_picker.dart';
import '../models/texto.dart';

//Clase editar que permite mostrar la ventana
class Edit extends StatefulWidget{
  @override
  //Instancia que crea la vista editar
  EditState createState() => EditState();
}

class EditState extends State<Edit> {
  //Obtenemos la imagen de add_data
  Uint8List? _img;
  //Creamos las variables para almacenar los datos de la base de datos
  String username = "";
  String userEmail = "";
  String userImage = "";
  String id = "";

  //Cargamos los datos de la base de datos
  Future<void> _loadUserInfo() async {
    //Obtenemos los datos del usuario
    final User? user = FirebaseAuth.instance.currentUser;
    //Si no existe el usuario, almacenar los datos en la base de datos con un ID unico
    if (user != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      //Si existe el usuario, almacenar en las variables los datos de la base de datos
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;

        // Verificar que las propiedades existen y no son nulas antes de acceder a ellas
        if (userData['nombre'] != null) {
          setState(() {
            //Asignar el valor a cada variable
            username = userData['nombre'];
            userEmail = userData['correo'];
            userImage = userData['imagenURL'];
            id = userData['uid'];
          });
        }
      }
    }
  }
  //inicializador de procesos
  @override
  void initState(){
    super.initState();
    _loadUserInfo();
  }
  //Si selecciona cambiar imagen por galeria, llamar a la eit_profile
  void selectImage() async{
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _img = image;
    });
    //Guardar los datos
    StoreData().saveData(file: _img!, userId: id);
  }

  //Si selecciona la camara obtener la imagen
  void cameraImage() async{
    Uint8List image = await pickImage(ImageSource.camera);
    setState(() {
      _img = image;
    });
    //Guardar los datos
    StoreData().saveData(file: _img!, userId: id);
  }

  //Construir la vista
  @override
  Widget build(BuildContext context) {
    //Obtener la diagonal del dispositivo
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      //Construcción de la ventana editar
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          //Construimos todos los apartados en una lista unica
          child: ListView(
            children: [
              //Titulo de la ventana
              Text(
                'Editar perfil',
                style: TextStyles.tituloNegro(responsive)
              ),
              //Espacio entre campos
              const SizedBox(height: 25),
              //Centrar imagen
              Center(
                child: Stack(
                  children: [
                    //Si existe, mostrar imagen del usuario
                    _img != null
                        ? CircleAvatar(
                      //Estilo de la imagen del usuario
                    radius: 60,
                      child: Container(
                        //tamaño de la imagen
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          //Decoración de la imagen
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              //Sombreado
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            )
                          ],
                          //Imprimir la imagen por defecto
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(_img!),
                          ),
                        ),
                      ),
                    )
                        : GestureDetector(
                      //Mostrar opciones al oprimir
                      onTap: () {
                        //Si selecciona galeria, obtener la imagen seleccionada
                        DialogHelper.showOptions(context, (ImageSource? source) async {
                          if (source == ImageSource.gallery) {
                            selectImage();
                            //Si se selecciona la camara, abrir la camara
                          } else if (source == ImageSource.camera) {
                            cameraImage();
                          }
                        });
                      },
                      //Decoración circulo de imagen
                      child: CircleAvatar(
                        radius: 60,
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                              )
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(userImage),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Lapiz que acompaña el circulo de la imagen
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: Colors.white),
                          color: Colors.red,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Espaciado entre campos
              const SizedBox(height: 15),
              //Parametros para edición
              Container(
                child: Column(
                  children: [
                    ListTile(
                    //Primer apartado, edicion de perfil
                      title: Text('Nombre de usuario'),
                      //Mostrar nombre actual
                      subtitle: Text(username),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        //Si oprime el campo mostrar la edición del nombre
                        onPressed: () {
                          DialogHelper.editProfile(
                            context,
                            'Nombre',
                            username,
                                (newName) {
                              //Almacenar el nuevo nombre
                              setState(() {
                                username = newName;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    Divider(),
                    ListTile(
                      //Segundo apartado, edición de correo
                      title: Text('Correo electrónico'),
                      //Mostrar correo actual
                      subtitle: Text(userEmail),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        //Si oprime el campo mostrar la edición del correo
                        onPressed: () {
                          DialogHelper.editProfile(
                            context,
                            'Correo',
                            userEmail,
                                (newEmail) {
                              //Almacenar el nuevo nombre
                              setState(() {
                                userEmail = newEmail;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    const Divider(),

                    ListTile(
                      //Tercer apartado, edición de contraseña
                      title: const Text('Contraseña'),
                      //Mostrar caracteres de contraseña
                      subtitle: const Text('********'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          //Mostrar ventana edicion contraseña
                          DialogHelper.editPassword(context);
                        },
                      ),
                    ),
                    Divider(),
                    Container(
                      //Acciones adicionales de la cuenta
                      color: const Color.fromARGB(255, 232, 232, 232),
                      width: double.infinity,
                      height: 25,
                      padding: const EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Control de la cuenta',
                          style: TextStyles.preguntas(responsive)
                        ),
                      ),
                    ),
                    Container(
                      //Cuarto apartado, eliminar perfil
                      alignment: Alignment.bottomLeft,
                      child: CupertinoButton(
                        child: Text(
                          //Mostrar titulo del campo
                          "Eliminar cuenta",
                            style: TextStyles.salidas(responsive)
                        ),
                        onPressed: () {
                          //Si se oprime, mostrar ventana eliminar cuenta
                          DialogHelper.deleteAccount(context, id);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
