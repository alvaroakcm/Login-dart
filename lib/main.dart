import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/CartProvider.dart';
import 'providers/plato_provider.dart';
import 'providers/restaurant_provider.dart';
import 'providers/usuario_provider.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/registro_cliente_screen.dart';
import 'screens/auth/registro_empresa_screen.dart';
import 'screens/auth/tipo_usuario_screen.dart';
import 'screens/home/Carrito_screen.dart';
import 'screens/home/home-screen2.dart';
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
        ChangeNotifierProvider(
          create: (_) => PlatoProvider(),
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(
          create: (_) => UserProvider(), // Agrega el UserProvider aquí
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
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) {
          final int userId =
              Provider.of<UserProvider>(context, listen: false).userId;
          return HomeScreen(userId: userId);
        },
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/register': (context) => const TipoUsuarioScreen(),
        '/register-client': (context) => RegistroClienteScreen(),
        '/register-company': (context) => RegistroEmpresaScreen(),
        '/carrito': (context) => const CartScreen(),
        '/home2': (context) {
          final userId =
              Provider.of<UserProvider>(context, listen: false).userId;
          return HomeScreen2(userId: userId);
        },
      },
    );
  }
}
