import 'package:flutter/material.dart';

import '../../widgets/app_logo.dart';
import '../../widgets/custom_button.dart';
import 'login_screen.dart';

class TipoUsuarioScreen extends StatelessWidget {
  const TipoUsuarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con curvas
          Positioned.fill(
            child: CustomPaint(
              painter: CurvedBackgroundPainter(),
            ),
          ),
          // Contenido de la pantalla
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botón de retroceso
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 20),

                // Logo y nombre de la aplicación
                const AppLogo(),
                const SizedBox(height: 40),

                const Text(
                  "Seleccione su tipo de cuenta",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),

                // Botones para Usuario y Empresa
                CustomButton(
                  text: "USUARIO",
                  onPressed: () {
                    Navigator.pushNamed(context, '/register-client');
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: "EMPRESA",
                  onPressed: () {
                    Navigator.pushNamed(context, '/register-company');
                  },
                ),
                const Spacer(),
                const Text(
                  "By: ARDUC",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
