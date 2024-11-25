import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pedido.dart';

class PedidoService {
  final String baseUrl = 'http://192.168.56.1:8875/api/pedidos';

  Future<Pedido> crearPedido(Pedido pedido) async {
    final response = await http.post(
      Uri.parse('$baseUrl/crear'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pedido.toJson()),
    );

    if (response.statusCode == 200) {
      return Pedido.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear el pedido');
    }
  }

  Future<List<Pedido>> obtenerPedidosPorUsuario(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl?userId=$userId'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((pedido) => Pedido.fromJson(pedido))
          .toList();
    } else {
      throw Exception('Error al obtener pedidos');
    }
  }

  Future<List<DetallePedido>> obtenerDetallesPorPedido(int pedidoId) async {
    final response = await http.get(Uri.parse('$baseUrl/$pedidoId/detalles'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((detalle) => DetallePedido.fromJson(detalle))
          .toList();
    } else {
      throw Exception('Error al obtener detalles del pedido');
    }
  }
}
