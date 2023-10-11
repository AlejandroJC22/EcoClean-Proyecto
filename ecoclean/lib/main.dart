import 'package:ecoclean/login.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MainApp());
}


class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoClean',
      home: Login(),
      theme: ThemeData(
        primaryColor: const Color(0xFF2F008E),
        hintColor: const Color(0xFFFDD303),
      ),
    );
  }
}
