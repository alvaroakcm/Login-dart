// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/restaurant_provider.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/tipo_usuario_screen.dart';
import 'screens/home/home_screen.dart';
import 'service/restaurant_service.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(
            restaurantService: RestaurantService(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: AppTheme.buildTheme(),
      initialRoute: '/', // Pantalla inicial, que será la de Login en este caso
      routes: {
        '/': (context) =>
            const LoginScreen(), // Pantalla de Login como entrada principal
        '/home': (context) =>
            const HomeScreen(), // Pantalla Home para la lista de restaurantes
        '/forgot-password': (context) =>
            const ForgotPasswordScreen(), // Pantalla de recuperación de contraseña
        '/register': (context) =>
            const TipoUsuarioScreen(), // Pantalla para registro de usuario
      },
    );
  }
}
