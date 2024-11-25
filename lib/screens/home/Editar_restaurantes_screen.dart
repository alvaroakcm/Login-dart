import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/restaurant.dart';
import '../../providers/restaurant_provider.dart';

class EditarRestauranteScreen extends StatefulWidget {
  final Restaurante restaurante;

  const EditarRestauranteScreen({super.key, required this.restaurante});

  @override
  _EditarRestauranteScreenState createState() =>
      _EditarRestauranteScreenState();
}

class _EditarRestauranteScreenState extends State<EditarRestauranteScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _restaurantName;
  late String _categoria;
  late String _horario;
  late String _direccion;
  late String _descripcion;
  late String _imagenUrl;

  @override
  void initState() {
    super.initState();
    _restaurantName = widget.restaurante.restaurantName;
    _categoria = widget.restaurante.categoria;
    _horario = widget.restaurante.horario;
    _direccion = widget.restaurante.direccion;
    _descripcion = widget.restaurante.descripcion;
    _imagenUrl = widget.restaurante.imagenUrl ?? '';
  }

  void _guardarCambios() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final restauranteEditado = Restaurante(
        restauranteId: widget.restaurante.restauranteId,
        restaurantName: _restaurantName,
        categoria: _categoria,
        horario: _horario,
        direccion: _direccion,
        descripcion: _descripcion,
        imagenUrl: _imagenUrl,
        estado: widget.restaurante.estado, // Valor existente
        rating: widget.restaurante.rating, // Valor existente
        userId: widget.restaurante.userId, // Valor existente
      );

      Provider.of<RestaurantProvider>(context, listen: false)
          .editarRestaurante(
              widget.restaurante.restauranteId, restauranteEditado)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Restaurante actualizado con éxito')),
        );
        Navigator.of(context).pop();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al actualizar el restaurante')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

                  // Título de la pantalla
                  const Text(
                    'Editar Restaurante',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Campos del formulario
                  TextFormField(
                    initialValue: _restaurantName,
                    decoration: const InputDecoration(
                        labelText: 'Nombre del Restaurante'),
                    onSaved: (value) => _restaurantName = value!,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _categoria,
                    decoration: const InputDecoration(labelText: 'Categoría'),
                    onSaved: (value) => _categoria = value!,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _horario,
                    decoration: const InputDecoration(labelText: 'Horario'),
                    onSaved: (value) => _horario = value!,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _direccion,
                    decoration: const InputDecoration(labelText: 'Dirección'),
                    onSaved: (value) => _direccion = value!,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _descripcion,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                    onSaved: (value) => _descripcion = value!,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _imagenUrl,
                    decoration:
                        const InputDecoration(labelText: 'URL de Imagen'),
                    onSaved: (value) => _imagenUrl = value!,
                  ),
                  const SizedBox(height: 20),

                  // Botón para guardar cambios
                  ElevatedButton(
                    onPressed: _guardarCambios,
                    child: const Text('Guardar Cambios'),
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
