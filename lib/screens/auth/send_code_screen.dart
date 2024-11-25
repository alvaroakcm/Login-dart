import 'package:flutter/material.dart';

class SendCodeScreen extends StatelessWidget {
  final String email;

  const SendCodeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo curvado
          Positioned.fill(
            child: Image.asset(
              'assets/curved_background.png',
              fit: BoxFit.cover,
            ),
          ),
          // Contenido principal
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icono o ilustración
                  const Icon(
                    Icons.email,
                    size: 100,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  // Mensaje de confirmación
                  const Text(
                    '¡Código Enviado!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'El código de recuperación ha sido enviado a:\n$email',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Botón
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Volver a la pantalla anterior
                    },
                    child: const Text(
                      'Volver al inicio de sesión',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
