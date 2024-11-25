import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/usuario.dart';

class UserService {
  final String baseUrl =
      "http://192.168.56.1:8872/usuarios"; // Cambia esta URL a la de tu backend

  Future<bool> registerUser(UsuarioDTO usuario) async {
    final url = Uri.parse('$baseUrl/crear'); // Ruta de registro en tu backend
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(usuario.toJson()),
      );

      if (response.statusCode == 201) {
        print("Usuario registrado con éxito.");
        return true;
      } else {
        print(
            'Error al registrar usuario: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"correo": email, "password": password});

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data; // Retorna el mapa con los datos del usuario
      } else {
        print('Error al iniciar sesión: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return null;
    }
  }
}
