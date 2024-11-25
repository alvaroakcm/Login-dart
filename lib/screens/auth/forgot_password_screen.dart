import 'package:flutter/material.dart';

import 'send_code_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String _errorMessage = '';

  // Función para enviar código de recuperación
  void _sendRecoveryCode() {
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      setState(() {
        _errorMessage = 'Por favor, ingrese un correo electrónico válido';
      });
    } else {
      // Simula el envío del código de recuperación
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SendCodeScreen(email: _emailController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo en la parte superior
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/curved_background.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ),
          // Botón para volver atrás
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.05, // Ajusta posición vertical
            left: 16, // Distancia del borde izquierdo
            child: IconButton(
              icon:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 0.15),
              onPressed: () {
                Navigator.of(context).pop(); // Navega hacia atrás
              },
            ),
          ),
          // Texto "Restablecer Contraseña" sobre la imagen superior
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                'Restablecer Contraseña',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Imagen en la parte inferior
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/curved_inferior.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ),
          // Contenido de la pantalla
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  'assets/logo 1.png',
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Ingresar e-mail',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'ejemplo@gmail.com',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Recuerda ingresar tu correo electrónico que anteriormente ha sido creado por el usuario en esta plataforma.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _sendRecoveryCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'Restablecer contraseña',
                    style: TextStyle(fontSize: 16),
                  ),
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
