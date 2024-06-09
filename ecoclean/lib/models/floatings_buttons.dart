// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class buildFloatingButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const buildFloatingButton({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: 30,
        ),
      ),
    );
  }
}
