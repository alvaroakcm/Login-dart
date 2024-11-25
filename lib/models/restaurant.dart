// models/restaurante_model.dart
class Restaurante {
  final int restauranteId;
  final String restaurantName;
  final String categoria;
  final String horario;
  final int estado;
  final String direccion;
  final double rating;
  final String descripcion;
  final String imagenUrl;
  final int userId;

  Restaurante({
    required this.restauranteId,
    required this.restaurantName,
    required this.categoria,
    required this.horario,
    required this.estado,
    required this.direccion,
    required this.rating,
    required this.descripcion,
    required this.imagenUrl,
    required this.userId,
  });

  factory Restaurante.fromJson(Map<String, dynamic> json) {
    return Restaurante(
      restauranteId: json['restauranteId'] ?? 0, // Si es null, asigna 0
      restaurantName: json['restaurantName'] ??
          'Sin nombre', // Si es null, asigna texto por defecto
      categoria: json['categoria'] ?? 'Sin categoría',
      horario: json['horario'] ?? 'Horario no especificado',
      estado: json['estado'] ?? 0, // Si es null, asigna 0
      direccion: json['direccion'] ?? 'Dirección no disponible',
      rating: (json['rating'] as num?)?.toDouble() ??
          0.0, // Convierte num a double y asigna 0.0 si es null
      descripcion: json['descripcion'] ?? 'Sin descripción',
      imagenUrl: json['imagenUrl'] ?? '', // Si es null, asigna cadena vacía
      userId: json['userId'] ?? 0, // Si es null, asigna 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'restauranteId': restauranteId,
      'restaurantName': restaurantName,
      'categoria': categoria,
      'horario': horario,
      'estado': estado,
      'direccion': direccion,
      'rating': rating,
      'descripcion': descripcion,
      'imagenUrl': imagenUrl,
      'userId': userId
    };
  }
}
