import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/plato_provider.dart';
import '../../providers/restaurant_provider.dart';
import '../../widgets/plato_card2.dart';

class PlatosScreen2 extends StatelessWidget {
  final int restauranteId;
  final String restaurantName;

  const PlatosScreen2({
    super.key,
    required this.restauranteId,
    required this.restaurantName,
  });

  @override
  Widget build(BuildContext context) {
    final platoProvider = Provider.of<PlatoProvider>(context, listen: false);
    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);

    // Cargar los datos cuando se abre la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      platoProvider.obtenerPlatosPorRestaurante(restauranteId);
      restaurantProvider.fetchRestaurantById(restauranteId);
    });

    return Scaffold(
      body: Stack(
        children: [
          // Fondo curvado superior
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/curved_background.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ),
          Column(
            children: [
              AppBar(
                title: Text(restaurantName),
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/carrito'); // Ruta de carrito
                    },
                  ),
                ],
              ),
              Expanded(
                child: Consumer2<PlatoProvider, RestaurantProvider>(
                  builder: (context, platoProvider, restaurantProvider, child) {
                    if (platoProvider.isLoading ||
                        restaurantProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (platoProvider.platos.isEmpty) {
                      return const Center(
                          child: Text("No hay platos disponibles"));
                    } else {
                      final restaurante = restaurantProvider.restaurante;
                      return ListView(
                        children: [
                          // Cabecera del Restaurante
                          if (restaurante != null) ...[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Imagen principal
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      restaurante.imagenUrl,
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Descripción y dirección
                                  Text(
                                    restaurante.descripcion,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: Colors.grey),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          restaurante.direccion,
                                          style: const TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  // Categorías
                                  const Wrap(
                                    spacing: 8.0,
                                    children: [
                                      Chip(label: Text('Salchipapa')),
                                      Chip(label: Text('Papas fritas')),
                                      Chip(label: Text('Hamburguesas')),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  const Text(
                                    "Salchipapas",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          // Lista de Platos
                          ...platoProvider.platos.map((plato) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: PlatoCard2(
                                plato: plato,
                              ),
                            );
                          }),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
