// services/api_service.dart
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/restaurant.dart';

class RestaurantService {
  final String baseUrl =
      "http://192.168.56.1:8873/api/restaurante"; // Cambia esto por la URL de tu backend

  Future<List<Restaurante>> getRestaurantesByUsuarioId(int userId) async {
    final url = Uri.parse('$baseUrl/usuarios/$userId'); // Endpoint específico

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Restaurante.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar restaurantes: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<List<Restaurante>> getAllRestaurantes() async {
    final response = await http.get(Uri.parse("$baseUrl/all"));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Restaurante.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar los restaurantes");
    }
  }

  Future<Restaurante> getRestauranteById(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));
    if (response.statusCode == 200) {
      return Restaurante.fromJson(json.decode(response.body));
    } else {
      throw Exception("Restaurante no encontrado");
    }
  }

  Future<Restaurante?> editarRestaurante(
      int id, Restaurante restaurante) async {
    final url = Uri.parse('$baseUrl/editar/$id');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(restaurante.toJson()),
      );

      if (response.statusCode == 200) {
        return Restaurante.fromJson(jsonDecode(response.body));
      } else {
        print(
            'Error al editar el restaurante: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error de conexión al editar el restaurante: $e');
      return null;
    }
  }

  Future<void> createRestaurante(Restaurante restaurante) async {
    final response = await http.post(
      Uri.parse("$baseUrl/create/restaurante"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(restaurante.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Error al crear restaurante");
    }
  }

  Future<void> eliminarRestaurante(int id) async {
    final url = Uri.parse('$baseUrl/eliminar/$id');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception("Error al eliminar el restaurante");
    }
  }
}
