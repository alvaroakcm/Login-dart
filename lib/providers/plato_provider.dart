// providers/plato_provider.dart
import 'package:flutter/material.dart';

import '../models/plato.dart';
import '../service/platos_service.dart';

class PlatoProvider with ChangeNotifier {
  final PlatosService _platosService = PlatosService();
  List<Plato> _platos = [];
  bool _isLoading = false;

  List<Plato> get platos => _platos;
  bool get isLoading => _isLoading;

  Future<void> addPlato(Plato plato) async {
    final newPlato = await _platosService.addPlato(plato);
    if (newPlato != null) {
      _platos.add(newPlato);
      notifyListeners();
    }
  }

  Future<void> editarPlato(int id, Plato plato) async {
    final platoEditado = await _platosService.editarPlato(id, plato);
    if (platoEditado != null) {
      // Actualiza la UI si es necesario
      notifyListeners();
    }
  }

  Future<void> obtenerPlatosPorRestaurante(int restauranteId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _platos = await _platosService.obtenerPlatosPorRestaurante(restauranteId);
    } catch (e) {
      print("Error al obtener platos: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> eliminarPlato(int? id) async {
    if (id == null) {
      print("Error: el ID es nulo y no se puede eliminar.");
      return;
    }
    try {
      await _platosService.eliminarPlato(id);
      _platos.removeWhere((plato) => plato.platoid == id);
      notifyListeners();
    } catch (e) {
      print("Error al eliminar plato: $e");
    }
  }
}
