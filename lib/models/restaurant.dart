// lib/models/restaurant.dart
class Restaurant {
  final String name;
  final String description;
  final double rating;
  final String imageUrl;

  Restaurant({
    required this.name,
    required this.description,
    required this.rating,
    required this.imageUrl,
  });

  // Constructor para crear un objeto a partir de JSON
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      description: json['description'],
      rating: json['rating'].toDouble(),
      imageUrl: json['imageUrl'],
    );
  }

  // Método para convertir un objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'rating': rating,
      'imageUrl': imageUrl,
    };
  }
}
