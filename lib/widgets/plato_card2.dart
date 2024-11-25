import 'package:flutter/material.dart';

import '../models/plato.dart';

class PlatoCard2 extends StatelessWidget {
  final Plato plato;
  const PlatoCard2({
    super.key,
    required this.plato,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Imagen del plato con manejo de URL nula
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                plato.imagenUrl ?? 'https://via.placeholder.com/150',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // En caso de error de carga de imagen
                  return Image.asset(
                    'assets/placeholder.png', // Asegúrate de tener un archivo de imagen placeholder en assets
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            // Información del plato
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plato.platoName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    plato.descripcion,
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    plato.precio != null
                        ? 'S/.${plato.precio.toStringAsFixed(2)}'
                        : 'Precio no disponible',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
            // Botón para agregar plato
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: Colors.teal),
              onPressed: () {
                // Acción para añadir plato
              },
            ),
          ],
        ),
      ),
    );
  }
}
