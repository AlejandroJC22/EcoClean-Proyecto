import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/views/edit.dart';
import 'package:flutter_ecoclean/views/favoritos.dart';
import 'package:flutter_ecoclean/views/home.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';
import 'package:flutter_ecoclean/views/login.dart';

import '../models/texto.dart';

class Menu extends StatefulWidget {
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  String username = "";
  String userEmail = "";
  String userImage = "";
  int _selectedDrawerItem = 0;


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
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return Home();
      case 1:
        return Edit();
      case 2:
        return Favorites();
      default:
        return Home();
    }
  }

  _onSelectItem(int pos) {
    Navigator.of(context).pop();
    setState(() {
      _selectedDrawerItem = pos;
    });
  }



  @override
  void didUpdateWidget(covariant Menu oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadUserInfo(); // Cargar la información del usuario al actualizar el widget
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Container(
        color: Colors.white,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: const Text('EcoClean Bogotá', style: TextStyle(color: Colors.green)),
            automaticallyImplyLeading: false,
          ),
          endDrawer: Drawer(
            child: Container(
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 30),
                  UserAccountsDrawerHeader(
                    accountName: Text(username, style: TextStyles.textoSinNegrita(responsive)),
                    accountEmail: Text(userEmail, style: TextStyles.textoSinNegrita(responsive)),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(userImage),
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(0,255,0,0.2),
                    ),
                  ),
                  ListTile(
                    leading: _selectedDrawerItem == 0 ? const Icon(Icons.arrow_forward_ios_sharp, color: Colors.green) : const Icon(Icons.arrow_back_ios),
                    trailing: _selectedDrawerItem == 0 ? const Icon(Icons.home, color: Colors.green) : const Icon(Icons.home),
                    selected: (0 == _selectedDrawerItem),
                    title: Text('Página principal', style: TextStyle(color: _selectedDrawerItem == 0 ? Colors.green : Colors.black, fontSize: 16)),
                    onTap: () {
                      _onSelectItem(0);
                    },
                  ),
                  ListTile(
                    leading: _selectedDrawerItem == 1 ? const Icon(Icons.arrow_forward_ios_sharp, color: Colors.green) : const Icon(Icons.arrow_back_ios),
                    trailing: _selectedDrawerItem == 1 ? const Icon(Icons.edit, color: Colors.green) : const Icon(Icons.edit),
                    selected: (1 == _selectedDrawerItem),
                    title: Text('Editar perfil', style: TextStyle(color: _selectedDrawerItem == 1 ? Colors.green : Colors.black, fontSize: 16)),
                    onTap: () {
                      _onSelectItem(1);
                    },
                  ),
                  ListTile(
                    leading: _selectedDrawerItem == 2 ? const Icon(Icons.arrow_forward_ios_sharp, color: Colors.green) : const Icon(Icons.arrow_back_ios),
                    trailing: _selectedDrawerItem == 2 ? const Icon(Icons.favorite, color: Colors.green) : const Icon(Icons.favorite),
                    selected: (2 == _selectedDrawerItem),
                    title: Text('Rutas favoritas', style: TextStyle(color: _selectedDrawerItem == 2 ? Colors.green : Colors.black, fontSize: 16)),
                    onTap: () {
                      _onSelectItem(2);
                    },
                  ),
                  const SizedBox(height: 300),
                  ListTile(
                    title: Text('Cerrar sesión', style: TextStyle(color: Colors.red, fontSize: 16)),
                    leading: const Icon(Icons.logout, color: Colors.red),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                  ),
                ],
              ),
          )
          ),
          body: _getDrawerItemWidget(_selectedDrawerItem),
        ),
    );
  }
}
