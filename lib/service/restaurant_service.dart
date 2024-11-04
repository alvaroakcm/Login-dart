import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/restaurant.dart';

class RestaurantService {
  final String baseUrl =
      "http://localhost:8873/api/restaurante"; // Cambia esto si es necesario

  // Método para obtener todos los restaurantes
  Future<List<Restaurant>> getAllRestaurants() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Restaurant.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los restaurantes');
    }
  }

  // Método para obtener un restaurante por ID
  Future<Restaurant> getRestaurantById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Restaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Restaurante no encontrado');
    }
  }

  // Método para obtener restaurantes por nombre
  Future<List<Restaurant>> getRestaurantsByName(String nombre) async {
    final response = await http.get(Uri.parse('$baseUrl/nombre/$nombre'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Restaurant.fromJson(json)).toList();
    } else {
      throw Exception('Error al buscar restaurantes por nombre');
    }
  }

  // Método para obtener restaurantes por categoría
  Future<List<Restaurant>> getRestaurantsByCategory(String categoria) async {
    final response = await http.get(Uri.parse('$baseUrl/categoria/$categoria'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Restaurant.fromJson(json)).toList();
    } else {
      throw Exception('Error al buscar restaurantes por categoría');
    }
  }

  // Método para crear un nuevo restaurante
  Future<Restaurant> createRestaurant(Restaurant restaurant) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create/restaurante'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(restaurant.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Restaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear el restaurante');
    }
  }

  // Método para eliminar un restaurante por ID
  Future<void> deleteRestaurant(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el restaurante');
    }
  }
}
