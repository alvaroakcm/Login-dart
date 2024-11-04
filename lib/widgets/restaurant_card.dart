import 'package:flutter/material.dart';

import '../models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
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
            // Imagen del restaurante con borde redondeado
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: restaurant.imageUrl.startsWith('http')
                  ? Image.network(
                      restaurant.imageUrl,
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      restaurant.imageUrl,
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 12),
            // Nombre del restaurante
            Text(
              restaurant.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            // Descripción del restaurante
            Text(
              restaurant.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            // Sección inferior con iconos y calificación
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Íconos de interacción (puedes añadir funciones onPressed)
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.star_border),
                      onPressed: () {},
                    ),
                  ],
                ),
                // Calificación del restaurante
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.teal),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.rating.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
