import 'package:firebase_auth/firebase_auth.dart';
import '../views/login.dart';
import 'package:flutter/material.dart';
import '../views/edit.dart';
import '../views/favoritos.dart';
import '../views/home.dart';
import '../utilidades/responsive.dart';
import '../models/texto.dart';

class Menu extends StatefulWidget {
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {

  int _selectDrawerItem = 0;
  _getDrawerItemWidget(pos) {
    switch (pos) {
      case 0:
        return Home();
      case 1:
        return Edit();
      case 2:
        return Favorites();
      case 3:
        return Login();
    }
  }

  _onSelectItem(int pos) {
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = pos;
    });

  }


  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white10,
          title: const Text('EcoClean Bogotá', style: TextStyle(color: Colors.green)),
          automaticallyImplyLeading: false,
        ),
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              const SizedBox(
                  height: 30
              ),
              UserAccountsDrawerHeader(
                accountName: Text('Usuario', style: TextStyles.textoSinNegrita(responsive)),
                accountEmail: Text( 'usuario@example.com',  style: TextStyles.textoSinNegrita(responsive)),
                currentAccountPicture: const CircleAvatar( backgroundColor: Colors.black, child: Text('U',
                    style: TextStyle(fontSize: 40), textAlign: TextAlign.justify),
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20,),
              ListTile(
                leading: _selectDrawerItem == 0 ? const Icon(Icons.arrow_forward_ios_sharp, color: Colors.red,) : const Icon(Icons.arrow_back_ios),
                trailing: _selectDrawerItem == 0 ? const Icon(Icons.home, color: Colors.red): const Icon(Icons.home),
                selected: (0 == _selectDrawerItem),
                title: Text('Página principal', style: TextStyle(color: _selectDrawerItem == 0 ? Colors.red : Colors.black,fontSize: responsive.ip(4))),
                onTap: () {
                  _onSelectItem(0);
                },
              ),
              ListTile(
                leading:_selectDrawerItem == 1 ? const Icon(Icons.arrow_forward_ios_sharp, color: Colors.red) : const Icon(Icons.arrow_back_ios),
                trailing: _selectDrawerItem == 1 ? const Icon(Icons.edit, color: Colors.red): const Icon(Icons.edit),
                selected: (1 == _selectDrawerItem),
                title: Text("Editar perfil", style: TextStyle(color: _selectDrawerItem == 1 ? Colors.red : Colors.black,fontSize: responsive.ip(4))),
                onTap: () {
                  _onSelectItem(1);
                },
              ),
              ListTile(
                leading: _selectDrawerItem == 2 ? const Icon(Icons.arrow_forward_ios_sharp, color: Colors.red) : const Icon(Icons.arrow_back_ios),
                trailing: _selectDrawerItem == 2 ? const Icon(Icons.favorite, color: Colors.red): const Icon(Icons.favorite),
                selected: (2 == _selectDrawerItem),
                title: Text("Rutas favoritas", style: TextStyle(color: _selectDrawerItem == 2 ? Colors.red : Colors.black,fontSize: responsive.ip(4))),
                onTap: () {
                  _onSelectItem(2);
                },
              ),
              const SizedBox(
                  height: 300
              ),
              ListTile(
                title: Text("Cerrar sesión", style: TextStyle(color: Colors.red, fontSize: responsive.ip(4))),
                leading: const Icon(Icons.logout, color: Colors.red),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                },
              )
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectDrawerItem));
  }
}
