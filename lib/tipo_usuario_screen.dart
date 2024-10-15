import 'package:flutter/material.dart';
import 'registro_cliente_screen.dart';
import 'registro_empresa_screen.dart';

class TipoUsuarioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Seleccione su tipo de usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton('Cliente', () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => RegistroClienteScreen()),
              );
            }),
            SizedBox(height: 20),
            _buildButton('Empresa', () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => RegistroEmpresaScreen()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
