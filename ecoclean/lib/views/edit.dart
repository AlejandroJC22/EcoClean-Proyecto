import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/controller/dialogHelper.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/views/editProfile/edit_profile.dart';
import 'package:image_picker/image_picker.dart';
import '../models/texto.dart';

class Edit extends StatefulWidget{
  @override
  EditState createState() => EditState();
}

class EditState extends State<Edit> {

  Uint8List? _img;


  String username = "";
  String userEmail = "";
  String userImage = "";

  Future<void> _loadUserInfo() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;

        // Verificar que las propiedades existen y no son nulas antes de acceder a ellas
        if (userData['nombre'] != null) {
          setState(() {
            username = userData['nombre'];
            userEmail = userData['correo'];
            userImage = userData['imagenURL'];
          });
        }
      }
    }
  }


  @override
  void initState(){
    super.initState();
    _loadUserInfo();
  }

  void selectImage() async{
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _img = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                'Editar perfil',
                style: TextStyles.tituloNegro(responsive)
              ),
              const SizedBox(height: 25),
              Center(
                child: Stack(
                  children: [
                    _img != null
                        ? CircleAvatar(
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
                            image: MemoryImage(_img!),
                          ),
                        ),
                      ),
                    )
                        : GestureDetector(
                      onTap: () {
                        selectImage();
                      },
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
              const SizedBox(height: 15),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Nombre de usuario'),
                      subtitle: Text(username),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          DialogHelper.editProfile(
                            context,
                            'Nombre',
                            username,
                                (newName) {
                              setState(() {
                                username = newName;
                              });
                              // Aquí puedes agregar la lógica para actualizar el nombre en Firebase Firestore
                            },
                          );
                        },
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Correo electrónico'),
                      subtitle: Text(userEmail),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          DialogHelper.editProfile(
                            context,
                            'Correo',
                            userEmail,
                                (newEmail) {
                              setState(() {
                                userEmail = newEmail;
                              });
                              // Aquí puedes agregar la lógica para actualizar el nombre en Firebase Firestore
                            },
                          );
                        },
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Contraseña'),
                      subtitle: Text('********'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Agregar lógica para editar el correo electrónico
                        },
                      ),
                    ),
                    Divider(),
                    Container(
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
                      alignment: Alignment.bottomLeft,
                      child: CupertinoButton(
                        child: Text(
                          "Eliminar cuenta",
                            style: TextStyles.salidas(responsive)
                        ),
                        onPressed: () {

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
