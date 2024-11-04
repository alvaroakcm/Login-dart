import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'login_screen.dart';

class RegistroEmpresaScreen extends StatelessWidget {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nombreEmpresaController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegistroEmpresaScreen({super.key});

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

                const Icon(
                  Icons.business, // Icono de empresa
                  size: 80,
                  color: Colors.black45,
                ),
                const SizedBox(height: 20),

                // Campos de texto para registro de empresa
                CustomTextField(
                    hintText: "Nombres", controller: _nombreController),
                const SizedBox(height: 10),
                CustomTextField(
                    hintText: "Apellidos", controller: _apellidoController),
                const SizedBox(height: 10),

                // Campos de texto de Celular y DNI
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "Celular",
                        controller: _celularController,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                        hintText: "DNI",
                        controller: _dniController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                CustomTextField(
                  hintText: "Correo Electrónico",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: "Nombre de la Empresa",
                  controller: _nombreEmpresaController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: "Contraseña",
                  controller: _passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 20),

                // Botón de registro
                CustomButton(
                  text: "REGISTRARME",
                  onPressed: () {
                    // Lógica de registro de empresa
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
