import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/controller/dialogHelper.dart';
import 'package:flutter_ecoclean/models/texto.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);
  @override
  ConfigPageState createState() => ConfigPageState();
}


class ConfigPageState extends State<ConfigPage> {

  int _selectedNotificationOption = 0;

  void _updateSelectedOption(int option) {
    setState(() {
      _selectedNotificationOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {

    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
            child: Text(
              'Configuración',
              style: TextStyles.tituloNegro(responsive),
            ),
          ),
          const SizedBox(height: 2,),
          ListTile(
            title: Text('Ciudad', style: TextStyle(fontSize: responsive.inch * 0.02)),
            subtitle: Text('Bogotá', style: TextStyle(fontSize: responsive.inch * 0.017)),
            onTap: (){
              DialogHelper.showCitys(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(),
          ),
          ListTile(
            title: Text('Notificaciones', style: TextStyle(fontSize: responsive.inch * 0.02)),
            onTap: (){
              DialogHelper.showNotifications(context,_selectedNotificationOption, _updateSelectedOption);
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(),
          ),
          ListTile(
            title: Text('Acerca de', style: TextStyle(fontSize: responsive.inch * 0.02)),
            onTap: (){
              DialogHelper.showInfo(context);
            },
          ),   
        ],
      ),
    );
  }
}