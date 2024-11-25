// service/platos_service.dart
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/plato.dart';

class PlatosService {
  final String baseUrl = 'http://192.168.56.1:8874/api/platos';

  Future<List<Plato>> obtenerPlatosPorRestaurante(int restauranteId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/restaurante/$restauranteId'));
      if (response.statusCode == 200) {
        List<dynamic> platosJson = json.decode(response.body);
        return platosJson.map((json) => Plato.fromJson(json)).toList();
      } else {
        print(
            'Error al obtener platos: Código de estado ${response.statusCode}');
        throw Exception(
            'Error al obtener platos: Código de estado ${response.statusCode}');
      }
    } on SocketException catch (e) {
      print("SocketException - No se pudo conectar con el servidor: $e");
      throw Exception("No se pudo conectar con el servidor");
    } on HttpException catch (e) {
      print("HttpException - Error HTTP: $e");
      throw Exception("Error en la respuesta HTTP");
    } on FormatException catch (e) {
      print("FormatException - Error al interpretar la respuesta: $e");
      throw Exception("Error al interpretar la respuesta del servidor");
    }
  }

  Future<Plato?> addPlato(Plato plato) async {
    final url = Uri.parse('$baseUrl/agregar_plato');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(plato.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Plato.fromJson(jsonDecode(response.body));
      } else {
        print('Error al agregar el plato: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error de conexión al agregar el plato: $e');
      return null;
    }
  }

  Future<Plato?> editarPlato(int id, Plato plato) async {
    final url = Uri.parse('$baseUrl/editar/$id');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(plato.toJson()),
      );

      if (response.statusCode == 200) {
        return Plato.fromJson(jsonDecode(response.body));
      } else {
        print(
            'Error al editar el plato: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error de conexión al editar el plato: $e');
      return null;
    }
  }

  Future<void> eliminarPlato(int id) async {
    final url = Uri.parse('$baseUrl/eliminar/$id');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception("Error al eliminar el plato");
    }
  }
}
