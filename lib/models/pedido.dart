class Pedido {
  final int pedidoId;
  final int userId;
  final int restauranteId;
  final String tipoEntrega;
  final String direccionEntrega;
  final String metodoPago;
  final String numeroOperacion;
  final DateTime fecha;
  final double total;
  final List<DetallePedido> detalles;

  Pedido({
    required this.pedidoId,
    required this.userId,
    required this.restauranteId,
    required this.tipoEntrega,
    required this.direccionEntrega,
    required this.metodoPago,
    required this.numeroOperacion,
    required this.fecha,
    required this.total,
    required this.detalles,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      pedidoId: json['pedidoId'],
      userId: json['userId'],
      restauranteId: json['restauranteId'],
      tipoEntrega: json['tipoEntrega'],
      direccionEntrega: json['direccionEntrega'],
      metodoPago: json['metodoPago'],
      numeroOperacion: json['numeroOperacion'],
      fecha: DateTime.parse(json['fecha']),
      total: json['total'],
      detalles: (json['detalles'] as List)
          .map((detalle) => DetallePedido.fromJson(detalle))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'restauranteId': restauranteId,
      'tipoEntrega': tipoEntrega,
      'direccionEntrega': direccionEntrega,
      'metodoPago': metodoPago,
      'numeroOperacion': numeroOperacion,
      'fecha': fecha.toIso8601String(),
      'total': total,
      'detalles': detalles.map((detalle) => detalle.toJson()).toList(),
    };
  }
}

class DetallePedido {
  final int detallePedidoId;
  final int platoId;
  final String platoName;
  final double precio;
  final int cantidad;
  final double subtotal;

  DetallePedido({
    required this.detallePedidoId,
    required this.platoId,
    required this.platoName,
    required this.precio,
    required this.cantidad,
    required this.subtotal,
  });

  factory DetallePedido.fromJson(Map<String, dynamic> json) {
    return DetallePedido(
      detallePedidoId: json['detallePedidoId'],
      platoId: json['platoId'],
      platoName: json['platoName'],
      precio: json['precio'],
      cantidad: json['cantidad'],
      subtotal: json['subtotal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platoId': platoId,
      'platoName': platoName,
      'precio': precio,
      'cantidad': cantidad,
      'subtotal': subtotal,
    };
  }
}
