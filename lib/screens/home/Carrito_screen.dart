import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/CartProvider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrito"),
        centerTitle: true,
      ),
      body: cartProvider.items.isEmpty
          ? const Center(
              child: Text(
                "Tu carrito está vacío.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartProvider.items[index];
                      return ListTile(
                        leading: cartItem.imagenUrl != null
                            ? Image.network(
                                cartItem.imagenUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/placeholder.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                        title: Text(cartItem.platoName),
                        subtitle: Text(
                          "S/${cartItem.precio.toString()} x ${cartItem.cantidad}",
                        ),
                        trailing: SizedBox(
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  cartProvider.removeFromCart(cartItem.platoid);
                                },
                              ),
                              Text(cartItem.cantidad.toString()),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  cartProvider.addToCart(cartItem);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Total: S/${cartProvider.totalPrice.toString()}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Lógica para confirmar el pedido
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Confirmar Pedido"),
                              content:
                                  const Text("¿Deseas confirmar tu pedido?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancelar"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cartProvider.clearCart();
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Pedido confirmado con éxito.")),
                                    );
                                  },
                                  child: const Text("Confirmar"),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        child: const Text(
                          "Confirmar Pedido",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          cartProvider.clearCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Carrito vaciado con éxito.")),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        child: const Text(
                          "Anular Compra",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
