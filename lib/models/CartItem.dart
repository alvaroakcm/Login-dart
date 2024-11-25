class CartItem {
  final int platoid;
  final String platoName;
  final int precio;
  final String imagenUrl;
  int cantidad;

  CartItem({
    required this.platoid,
    required this.platoName,
    required this.precio,
    required this.imagenUrl,
    this.cantidad = 1,
  });
}
