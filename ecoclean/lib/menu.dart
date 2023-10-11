import 'package:ecoclean/login.dart';
import 'package:flutter/material.dart';
import 'edit.dart';
import 'config.dart';
import 'favoritos.dart';
import 'home.dart';

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
        return Config();
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
    return Scaffold(
        appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white10,
        title: const Text('EcoClean Bogotá', style: TextStyle(color: Colors.green)),        
      ),
        endDrawer: Drawer(
          child: ListView(
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Text('Usuario', style: TextStyle(color: Colors.black)),
                accountEmail: Text( 'usuario@example.com',  style: TextStyle(color: Colors.black)),
                currentAccountPicture: CircleAvatar( backgroundColor: Colors.black, child: Text('U',
                style: TextStyle(fontSize: 40), textAlign: TextAlign.center),
                ),
                decoration: BoxDecoration(
                  color: Colors.white, // Cambia el fondo a blanco
                ),
              ),
              
              ListTile(
                leading: _selectDrawerItem == 0 ? const Icon(Icons.arrow_forward_ios_sharp, color: Colors.red,) : const Icon(Icons.arrow_back_ios),
                trailing: _selectDrawerItem == 0 ? const Icon(Icons.home, color: Colors.red): const Icon(Icons.home),
                selected: (0 == _selectDrawerItem),
                title: Text('Página principal', style: TextStyle(color: _selectDrawerItem == 0 ? Colors.red : Colors.black,)),
                onTap: () {
                  _onSelectItem(0);
                },
              ),
              ListTile(
                leading:_selectDrawerItem == 1 ? const Icon(Icons.arrow_forward_ios_sharp, color: Colors.red) : const Icon(Icons.arrow_back_ios),
                trailing: _selectDrawerItem == 1 ? const Icon(Icons.edit, color: Colors.red): const Icon(Icons.edit),
                selected: (1 == _selectDrawerItem),
                title: Text("Editar perfil", style: TextStyle(color: _selectDrawerItem == 1 ? Colors.red : Colors.black,)),
                onTap: () {
                  _onSelectItem(1);
                },
              ),
              ListTile(
                leading: _selectDrawerItem == 2 ? const Icon(Icons.arrow_forward_ios_sharp, color: Colors.red) : const Icon(Icons.arrow_back_ios),
                trailing: _selectDrawerItem == 2 ? const Icon(Icons.favorite, color: Colors.red): const Icon(Icons.favorite),
                selected: (2 == _selectDrawerItem),
                title: Text("Rutas favoritas", style: TextStyle(color: _selectDrawerItem == 2 ? Colors.red : Colors.black,)),
                onTap: () {
                  _onSelectItem(2);
                },
              ),
              const Divider(),
              ListTile(
                leading:  _selectDrawerItem == 3 ? const Icon(Icons.arrow_forward_ios_sharp, color: Colors.red) : const Icon(Icons.arrow_back_ios),
                trailing: _selectDrawerItem == 3 ? const Icon(Icons.settings, color: Colors.red): const Icon(Icons.settings),
                selected: (3 == _selectDrawerItem),
                title: Text("Ajustes adicionales", style: TextStyle(color: _selectDrawerItem == 3 ? Colors.red : Colors.black,)),
                onTap: () {
                  _onSelectItem(3);
                },
              ),
              const SizedBox(
                height: 300
              ),
              ListTile(
                title: const Text("Cerrar sesión", style: TextStyle(color: Colors.red)),
                leading: const Icon(Icons.logout, color: Colors.red,),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                },
              )
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectDrawerItem));
  }
}
