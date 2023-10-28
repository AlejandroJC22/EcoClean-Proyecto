import 'package:flutter/material.dart';

class Inputs extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText; // Agregamos un parámetro booleano

  Inputs({
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
