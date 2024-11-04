import 'package:flutter/material.dart';

class SendCodeScreen extends StatelessWidget {
  final String email;

  const SendCodeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Código de Recuperación Enviado'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'El código de recuperación ha sido enviado a $email. Por favor revisa tu correo electrónico.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Volver a la pantalla anterior
              },
              child: const Text('Volver al inicio de sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
