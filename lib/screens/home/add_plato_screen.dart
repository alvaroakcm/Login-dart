import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/plato.dart';
import '../../providers/plato_provider.dart';

class AddPlatoScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // Controladores de los campos del formulario
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController imagenUrlController = TextEditingController();

  final int restauranteId;

  AddPlatoScreen({super.key, required this.restauranteId});

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
                    'Agregar Plato',
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
                    controller: descripcionController,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: precioController,
                    decoration: const InputDecoration(labelText: 'Precio'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: imagenUrlController,
                    decoration:
                        const InputDecoration(labelText: 'URL de Imagen'),
                  ),
                  const SizedBox(height: 20),

                  // Botón para agregar plato
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newPlato = Plato(
                          platoid: 0,
                          platoName: nombreController.text,
                          descripcion: descripcionController.text,
                          precio: int.parse(precioController.text),
                          restauranteId: restauranteId,
                          imagenUrl: imagenUrlController.text,
                          disponible: true,
                        );
                        Provider.of<PlatoProvider>(context, listen: false)
                            .addPlato(newPlato);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Agregar Plato'),
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
