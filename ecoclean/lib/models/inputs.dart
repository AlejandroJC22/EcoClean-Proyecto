import 'package:flutter/material.dart';
import 'package:flutter_ecoclean/utilidades/responsive.dart';

class TextFieldContainer extends StatelessWidget{
  final Widget child;
  const TextFieldContainer({super.key,
    required this.child,
});

  @override
  Widget build(BuildContext context){
    Responsive responsive = Responsive.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: responsive.width * 0.9,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(231, 231, 231, 0.3),
          borderRadius: BorderRadius.circular(29),
        ),
        child: child,
      ),
    );
  }

}