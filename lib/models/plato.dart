class Plato {
  final int platoid; // Usa `int?` si puede ser null
  final String platoName;
  final String descripcion;
  final int precio; // Usa `int?` si puede ser null
  final bool disponible;
  final int restauranteId; // Usa `int?` si puede ser null
  final String imagenUrl;
  final double? precioPromocional; // Usa `double?` si puede ser null
  final String? categoria;

  Plato({
    required this.platoid, // Cambia a `this.id` si es opcional
    required this.platoName,
    required this.descripcion,
    required this.precio, // Cambia a `this.precio` si es opcional
    required this.disponible,
    required this.restauranteId, // Cambia a `this.restauranteId` si es opcional
    required this.imagenUrl,
    this.precioPromocional, // Cambia a `this.precioPromocional` si es opcional
    this.categoria,
  });

  factory Plato.fromJson(Map<String, dynamic> json) {
    return Plato(
      platoid: json['platoId'],
      platoName: json['platoName'] ?? '', // Valor predeterminado si es null
      descripcion: json['descripcion'] ?? '', // Manejo de null
      precio: json['precio'] ?? 0, // Valor predeterminado si es null
      precioPromocional: json['precioPromocional'] != null
          ? (json['precioPromocional'] as num).toDouble()
          : null, // Manejo de null para campos opcionales
      disponible:
          json['disponible'] ?? false, // Valor predeterminado si es null
      restauranteId:
          json['restauranteId'] ?? 0, // Valor predeterminado si es null
      imagenUrl: json['imagenUrl'] ?? '', // Valor predeterminado si es null
      categoria: json['categoria'], // Puede ser null
    );
  }

  // Método toJson para convertir el plato en un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'platoId': platoid,
      'platoName': platoName,
      'descripcion': descripcion,
      'precio': precio,
      'restauranteId': restauranteId,
      'imagenUrl': imagenUrl,
      'disponible': disponible,
      'categoria': categoria,
    };
  }
}
