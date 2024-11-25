import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/plato.dart';
import '../../providers/plato_provider.dart';

class EditarPlatoScreen extends StatefulWidget {
  final Plato plato;

  const EditarPlatoScreen({super.key, required this.plato});

  @override
  _EditarPlatoScreenState createState() => _EditarPlatoScreenState();
}

class _EditarPlatoScreenState extends State<EditarPlatoScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _platoName;
  late String _descripcion;
  late int _precio;
  late String _imagenUrl;

  @override
  void initState() {
    super.initState();
    _platoName = widget.plato.platoName;
    _descripcion = widget.plato.descripcion;
    _precio = widget.plato.precio;
    _imagenUrl = widget.plato.imagenUrl ?? '';
  }

  void _guardarCambios() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final platoEditado = Plato(
        platoid: widget.plato.platoid,
        platoName: _platoName,
        descripcion: _descripcion,
        precio: _precio,
        disponible: widget.plato.disponible,
        restauranteId: widget.plato.restauranteId,
        imagenUrl: _imagenUrl,
        categoria: widget.plato.categoria,
      );

      Provider.of<PlatoProvider>(context, listen: false)
          .editarPlato(widget.plato.platoid, platoEditado)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plato actualizado con éxito')),
        );
        Navigator.of(context).pop();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al actualizar el plato')),
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
                    'Editar Plato',
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
                    initialValue: _platoName,
                    decoration:
                        const InputDecoration(labelText: 'Nombre del Plato'),
                    onSaved: (value) => _platoName = value!,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _descripcion,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                    onSaved: (value) => _descripcion = value!,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    initialValue: _precio.toString(),
                    decoration: const InputDecoration(labelText: 'Precio'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _precio = int.parse(value!),
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
