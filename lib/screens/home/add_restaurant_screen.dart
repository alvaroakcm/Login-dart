import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/restaurant.dart';
import '../../providers/restaurant_provider.dart';
import '../../providers/usuario_provider.dart';

class AddRestaurantScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final int userId; // Define el tipo correctamente

  // Controladores de los campos del formulario
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController horarioController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController imagenUrlController = TextEditingController();

  AddRestaurantScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context, listen: false).userId;

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
          // Fondo curvado inferior
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/curved_inferior.png', // Ruta de la imagen inferior
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.15,
            ),
          ),
          // Contenido de la pantalla
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 40), // Espacio inicial
                  // Botón de retroceso
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campos del formulario
                  TextFormField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa el nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: categoriaController,
                    decoration: const InputDecoration(labelText: 'Categoría'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: horarioController,
                    decoration: const InputDecoration(labelText: 'Horario'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: direccionController,
                    decoration: const InputDecoration(labelText: 'Dirección'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: descripcionController,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: imagenUrlController,
                    decoration:
                        const InputDecoration(labelText: 'URL de Imagen'),
                  ),
                  const SizedBox(height: 20),

                  // Botón para agregar restaurante
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newRestaurant = Restaurante(
                          restauranteId: 0, // Se generará automáticamente
                          restaurantName: nombreController.text,
                          categoria: categoriaController.text,
                          horario: horarioController.text,
                          estado: 1,
                          direccion: direccionController.text,
                          rating: 0.0,
                          descripcion: descripcionController.text,
                          imagenUrl: imagenUrlController.text,
                          userId: userId,
                        );

                        Provider.of<RestaurantProvider>(context, listen: false)
                            .addRestaurant(newRestaurant);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Agregar Restaurante'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
