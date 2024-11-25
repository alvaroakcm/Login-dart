import 'package:flutter/material.dart';

import '../models/CartItem.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  // Total calculado como entero
  int get totalPrice =>
      _items.fold(0, (total, item) => total + (item.precio * item.cantidad));

  void addToCart(CartItem item) {
    final existingIndex =
        _items.indexWhere((cartItem) => cartItem.platoid == item.platoid);
    if (existingIndex >= 0) {
      _items[existingIndex].cantidad++;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeFromCart(int platoid) {
    final existingIndex =
        _items.indexWhere((cartItem) => cartItem.platoid == platoid);
    if (existingIndex >= 0) {
      if (_items[existingIndex].cantidad > 1) {
        _items[existingIndex].cantidad--;
      } else {
        _items.removeAt(existingIndex);
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
