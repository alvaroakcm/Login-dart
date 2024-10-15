import 'package:flutter/material.dart';
import 'home_screen.dart'; // Asegúrate de tener creada esta pantalla
import 'forgot_password_screen.dart'; // Pantalla de olvido de contraseña
import 'tipo_usuario_screen.dart'; // Pantalla de registro

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  // Método para simular login
  void _login() {
    setState(() {
      _errorMessage = '';
    });

    // Validar campos vacíos
    if (_userController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, llene todos los campos';
      });
      return;
    }

    // Simulación de login exitoso
    if (_userController.text == 'admin' && _passwordController.text == '1234') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      setState(() {
        _errorMessage = 'Usuario o contraseña incorrectos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[200]!, Colors.teal[600]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/logo.png', // Aquí cargas la imagen
                height: 100, // Ajusta el tamaño del logo según lo necesites
              ),
              SizedBox(height: 20),

              // Usuario
              _buildTextField(_userController, 'Usuario'),
              SizedBox(height: 20),

              // Contraseña
              _buildTextField(_passwordController, 'Contraseña',
                  isPassword: true),
              SizedBox(height: 10),

              // "Olvidaste tu contraseña?"
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen()),
                    );
                  },
                  child: Text('¿Olvidaste tu contraseña?',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),

              // Botón de ingreso
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent[400],
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 64),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _login, // Llamamos al método login
                child: Text('INGRESAR',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              SizedBox(height: 20),

              // Mensaje de error
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Text(
                      _errorMessage,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

              SizedBox(height: 20),

              // Registro
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => TipoUsuarioScreen()),
                  );
                },
                child: Text('¿Eres nuevo? Regístrate',
                    style: TextStyle(color: Colors.white)),
              ),

              SizedBox(height: 20),

              // Credito en la parte inferior
              Text('Por: AKCM the best programer',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
