import 'package:flutter/material.dart';

class RegistroClienteScreen extends StatefulWidget {
  @override
  _RegistroClienteScreenState createState() => _RegistroClienteScreenState();
}

class _RegistroClienteScreenState extends State<RegistroClienteScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _registerClient() {
    // Aquí puedes manejar la lógica de registro
    print(
        'Cliente registrado: ${_nombreController.text} ${_apellidoController.text}');
    // Luego podrías redirigir a otra pantalla o mostrar un mensaje de éxito
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear cuenta de usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _apellidoController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: _celularController,
              decoration: InputDecoration(labelText: 'Celular'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerClient,
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
