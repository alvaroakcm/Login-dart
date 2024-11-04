import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double logoSize;

  const AppLogo({super.key, this.logoSize = 100});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/logo 1.png', // Reemplaza con la ruta correcta a tu logo
          height: logoSize,
        ),
        const SizedBox(height: 10),
        const Text(
          "ÑAÑA POINT'S",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
