import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/usuario.dart';
import '../../providers/usuario_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'login_screen.dart';

class RegistroClienteScreen extends StatelessWidget {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegistroClienteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

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
          // Contenido de la pantalla con desplazamiento
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 60), // Espacio inicial

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
                  Icons.person, // Icono de usuario
                  size: 80,
                  color: Colors.black45,
                ),
                const SizedBox(height: 20),

                // Campos de texto para registro de cliente
                CustomTextField(
                  hintText: "Nombres",
                  controller: _nombreController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: "Apellidos",
                  controller: _apellidoController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: "Celular",
                  controller: _celularController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: "Correo Electrónico",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  onPressed: () async {
                    // Crear el objeto UsuarioDTO con los datos ingresados
                    final nuevoUsuario = UsuarioDTO(
                      userId: 0,
                      userName: _nombreController.text,
                      apellido: _apellidoController.text,
                      correo: _emailController.text,
                      telefono: _celularController.text,
                      password: _passwordController.text,
                      tipoUsuario: 'cliente', // Ajusta según el tipo de usuario
                    );

                    // Llamar al método de registro del UserProvider
                    final success =
                        await userProvider.registrarUsuario(nuevoUsuario);

                    if (success) {
                      // Si el registro fue exitoso, navega de vuelta a la pantalla de inicio de sesión
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    } else {
                      // Si hay un error, muestra un mensaje de error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Error al registrar el usuario')),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),

                const Text(
                  "By: ARDUC",
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
