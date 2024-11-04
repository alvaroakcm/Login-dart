import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/restaurant_provider.dart';
import '../../theme/app_colors.dart'; // Asegúrate de tener los colores definidos
import '../../widgets/restaurant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Llamar a fetchRestaurants() al iniciar la pantalla
    Future.microtask(() => Provider.of<RestaurantProvider>(context,
            listen: false)
        .fetchAllRestaurants()); // Asegúrate de que este método esté configurado para obtener datos del backend
  }

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = context.watch<RestaurantProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Inicio")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Barra de búsqueda
            _buildSearchBar(),
            const SizedBox(height: 20),

            // Categorías
            const Text(
              "Categorías",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 10),
            _buildCategoriesRow(),
            const SizedBox(height: 20),

            // Lista de restaurantes
            const Text(
              "Restaurantes",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 10),

            // Muestra el estado de carga o la lista de restaurantes
            Expanded(
              child: restaurantProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: restaurantProvider.restaurants.length,
                      itemBuilder: (context, index) {
                        return RestaurantCard(
                          restaurant: restaurantProvider.restaurants[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Construir la barra de búsqueda
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Buscar Restaurante",
                border: InputBorder.none,
              ),
              onChanged: (value) {
                // Lógica de filtrado basada en el valor ingresado
              },
            ),
          ),
        ],
      ),
    );
  }

  // Construir fila de categorías
  Widget _buildCategoriesRow() {
    final categories = [
      "Pollos y parrillas",
      "Pescados y mariscos",
      "Vegetarianos",
      "Chifas",
      "Pizzerias"
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Chip(
              label: Text(category),
              backgroundColor: AppColors.primaryColor.withOpacity(0.2),
              avatar: const Icon(Icons.category, color: AppColors.primaryColor),
            ),
          );
        }).toList(),
      ),
    );
  }
}
