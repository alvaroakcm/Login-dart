import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../service/restaurant_service.dart';

class RestaurantProvider with ChangeNotifier {
  final RestaurantService restaurantService;

  // Variables para la lista de restaurantes y para un solo restaurante
  List<Restaurante> _restaurantes = [];
  Restaurante? _restaurante; // Variable para un solo restaurante

  bool _isLoading = false;

  RestaurantProvider({required this.restaurantService});

  // Getters
  List<Restaurante> get restaurantes => _restaurantes;
  bool get isLoading => _isLoading;
  Restaurante? get restaurante => _restaurante; // Aquí está el nuevo getter

  Future<void> fetchAllRestaurants() async {
    _isLoading = true;
    notifyListeners();
    try {
      _restaurantes = await restaurantService.getAllRestaurantes();
    } catch (e) {
      print("Error al cargar restaurantes: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  void filterRestaurants(String query) {
    // Implementar la lógica de filtrado aquí
    notifyListeners();
  }

  void filterByCategory(String category) {
    // Filtrar los restaurantes por categoría
    notifyListeners();
  }

  Future<void> fetchRestaurants() async {
    _isLoading = true;
    notifyListeners();
    try {
      _restaurantes = await restaurantService.getAllRestaurantes();
    } catch (e) {
      print("Error al cargar restaurantes: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  // Método para obtener un restaurante por ID
  Future<void> fetchRestaurantById(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _restaurante = await restaurantService.getRestauranteById(id);
    } catch (e) {
      print("Error al cargar restaurante: $e");
      _restaurante = null;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addRestaurant(Restaurante restaurante) async {
    try {
      await restaurantService.createRestaurante(restaurante);
      _restaurantes.add(restaurante);
      notifyListeners();
    } catch (e) {
      print("Error al crear restaurante: $e");
    }
  }

  Future<void> editarRestaurante(int id, Restaurante restaurante) async {
    final restauranteEditado =
        await restaurantService.editarRestaurante(id, restaurante);
    if (restauranteEditado != null) {
      // Actualiza la UI si es necesario
      notifyListeners();
    }
  }

  Future<void> eliminarRestaurante(int id) async {
    try {
      await restaurantService.eliminarRestaurante(id);
      _restaurantes
          .removeWhere((restaurante) => restaurante.restauranteId == id);
      notifyListeners();
    } catch (e) {
      print("Error al eliminar restaurante: $e");
    }
  }

  // Filtrar restaurantes por usuario
  Future<void> fetchRestaurantsByUsuario(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _restaurantes =
          await restaurantService.getRestaurantesByUsuarioId(userId);
    } catch (e) {
      _restaurantes = [];
      print("Error al cargar los restaurantes: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
