import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Importar el provider de usuario
import '../../providers/usuario_provider.dart';
import '../../theme/app_colors.dart'; // Importar los colores
import '../../widgets/app_logo.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../home/home-screen2.dart';
import '../home/home_screen.dart';

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
  void _login() async {
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

    // Llamar al método de login del provider de usuario
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final loginSuccess = await userProvider.login(
      _userController.text,
      _passwordController.text,
      context,
    );

    if (loginSuccess) {
      // Obtener el usuarioId desde el provider
      final userId = userProvider.userId;
      // Redirigir al tipo de pantalla correspondiente según el tipo de usuario
      if (userProvider.tipoUsuario == 'administrador') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(userId: userId),
          ),
        );
      } else if (userProvider.tipoUsuario == 'cliente') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen2(userId: userId),
          ),
        );
      }
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
          // Fondo curvado superior
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/curved_background.png', // Ruta de la imagen superior
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ),
          // Fondo curvado inferior
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/curved_inferior.png', // Ruta de la imagen inferior
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.15,
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
