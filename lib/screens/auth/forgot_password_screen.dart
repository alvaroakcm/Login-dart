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
      appBar: AppBar(
        title: const Text('Recuperar Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration:
                  const InputDecoration(labelText: 'Correo electrónico'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendRecoveryCode,
              child: const Text('Enviar Código'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}