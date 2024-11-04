import 'package:flutter/material.dart';

import '../../theme/app_colors.dart'; // Importar los colores
import '../../widgets/app_logo.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = ''; // Para mostrar mensajes de error

  // Simulación de login
  void _login() {
    setState(() {
      _errorMessage = ''; // Limpiar el mensaje de error antes de validar
    });

    // Validar campos vacíos
    if (_userController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, ingrese su usuario y contraseña';
      });
      return;
    }

    // Validación simulada de credenciales (puedes reemplazarla con lógica real más adelante)
    if (_userController.text == 'admin' && _passwordController.text == '1234') {
      Navigator.pushReplacementNamed(
          context, '/home'); // Navegar a la pantalla principal (home)
    } else {
      setState(() {
        _errorMessage = 'Usuario o contraseña incorrectos';
      });
    }
  }

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
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),

                  // Logo y nombre de la aplicación
                  const AppLogo(),
                  const SizedBox(height: 40),

                  // Campo de usuario
                  CustomTextField(
                      hintText: "Usuario", controller: _userController),
                  const SizedBox(height: 20),

                  // Campo de contraseña
                  CustomTextField(
                    hintText: "Contraseña",
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),

                  // Enlace de contraseña olvidada
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context,
                            '/forgot-password'); // Navegar a la pantalla de recuperación de contraseña
                      },
                      child: const Text(
                        "Olvidé mi contraseña",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Mensaje de error
                  if (_errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

                  // Botón de ingresar
                  CustomButton(
                    text: "INGRESAR",
                    onPressed: _login,
                  ),
                  const SizedBox(height: 20),

                  // Enlace para registrarse
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("¿Eres nuevo? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          "Regístrate",
                          style: TextStyle(
                            color: AppColors.textColorLink,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 2),
                  const Text(
                    "By: ARDUC",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryColor // Color definido
      ..style = PaintingStyle.fill;

    // Ajustar la Curva Superior
    final pathTop = Path()
      ..moveTo(
          0,
          size.height *
              0.0) // Inicio de la curva en la parte superior izquierda
      ..lineTo(0,
          size.height * 0.15) // Línea vertical corta para darle altura inicial
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.05, // Punto de control (más arriba que antes)
        size.width, size.height * 0.15, // Punto final (más arriba que antes)
      )
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(pathTop, paint);

    // Ajustar la Curva Inferior (sin cambios)
    final pathBottom = Path()
      ..moveTo(0, size.height * 0.8)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.95,
        size.width,
        size.height * 0.8,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(pathBottom, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
