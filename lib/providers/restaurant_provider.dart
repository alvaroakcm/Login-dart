import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../models/restaurant.dart';
import '../service/restaurant_service.dart';

class RestaurantProvider with ChangeNotifier {
  final RestaurantService restaurantService;
  final Logger _logger = Logger();
  List<Restaurant> _restaurants = [];
  bool _isLoading = false;

  RestaurantProvider({required this.restaurantService});

  List<Restaurant> get restaurants => _restaurants;
  bool get isLoading => _isLoading;

  // Método para cargar todos los restaurantes
  Future<void> fetchAllRestaurants() async {
    _isLoading = true;
    notifyListeners();

    try {
      _restaurants = await restaurantService.getAllRestaurants();
      _logger.i("Restaurants fetched successfully.");
    } catch (e) {
      _logger.e("Error al cargar restaurantes", e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
