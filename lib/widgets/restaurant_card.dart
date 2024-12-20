import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../screens/home/Editar_restaurantes_screen.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurante restaurant;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Llama a la función `onTap` pasada desde HomeScreen
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: restaurant.imagenUrl.startsWith('http')
                    ? Image.network(
                        restaurant.imagenUrl,
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        restaurant.imagenUrl,
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 12),
              Text(
                restaurant.restaurantName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                restaurant.descripcion,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      restaurant.categoria,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      restaurant.direccion,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Botones juntos al lado derecho
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Botón de editar
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditarRestauranteScreen(
                            restaurante: restaurant,
                          ),
                        ),
                      );
                    },
                  ),
                  // Botón de eliminar
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
