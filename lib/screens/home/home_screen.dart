import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/restaurant_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/restaurant_card.dart';
import 'add_restaurant_screen.dart';
import 'platos_screen.dart';

class HomeScreen extends StatefulWidget {
  final int userId; // Nuevo parámetro para recibir el usuarioId

  const HomeScreen({super.key, required this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RestaurantProvider>(context, listen: false)
          .fetchRestaurantsByUsuario(widget.userId); // Usar usuarioId
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = context.watch<RestaurantProvider>();

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
          // Contenido principal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100), // Espacio para el fondo curvado
                _buildSearchBar(restaurantProvider),
                const SizedBox(height: 20),
                const Text(
                  "Categorías",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                _buildCategoriesRow(restaurantProvider),
                const SizedBox(height: 20),
                const Text(
                  "Restaurantes",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: restaurantProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: restaurantProvider.restaurantes.length,
                          itemBuilder: (context, index) {
                            final restaurant =
                                restaurantProvider.restaurantes[index];
                            return RestaurantCard(
                              restaurant: restaurant,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlatosScreen(
                                      restauranteId: restaurant.restauranteId,
                                      restauranteNombre:
                                          restaurant.restaurantName,
                                    ),
                                  ),
                                );
                              },
                              onDelete: () {
                                // Eliminar restaurante usando el proveedor
                                restaurantProvider.eliminarRestaurante(
                                    restaurant.restauranteId);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRestaurantScreen(userId: widget.userId),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSearchBar(RestaurantProvider provider) {
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
                provider.filterRestaurants(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesRow(RestaurantProvider provider) {
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
            child: GestureDetector(
              onTap: () {
                provider.filterByCategory(category);
              },
              child: Chip(
                label: Text(category),
                backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                avatar:
                    const Icon(Icons.category, color: AppColors.primaryColor),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
