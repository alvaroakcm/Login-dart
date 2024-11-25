import 'package:flutter/material.dart';

import '../models/pedido.dart';
import '../service/pedido_service.dart';

class PedidosProvider extends ChangeNotifier {
  final PedidoService _pedidoService = PedidoService();
  List<Pedido> _pedidos = [];
  List<DetallePedido> _detalles = [];
  bool _isLoading = false;

  // Getters
  List<Pedido> get pedidos => _pedidos;
  List<DetallePedido> get detalles => _detalles;
  bool get isLoading => _isLoading;

  // Método para obtener pedidos por usuario
  Future<void> obtenerPedidosPorUsuario(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _pedidos = await _pedidoService.obtenerPedidosPorUsuario(userId);
    } catch (e) {
      _pedidos = [];
      print('Error al obtener pedidos: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Método para obtener detalles de un pedido
  Future<void> obtenerDetallesPorPedido(int pedidoId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _detalles = await _pedidoService.obtenerDetallesPorPedido(pedidoId);
    } catch (e) {
      _detalles = [];
      print('Error al obtener detalles: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Método para crear un pedido
  Future<void> crearPedido(Pedido pedido) async {
    _isLoading = true;
    notifyListeners();

    try {
      final nuevoPedido = await _pedidoService.crearPedido(pedido);
      _pedidos.add(nuevoPedido);
      notifyListeners();
    } catch (e) {
      print('Error al crear pedido: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
