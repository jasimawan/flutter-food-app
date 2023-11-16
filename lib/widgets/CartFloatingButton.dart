import 'package:flutter/material.dart';
import 'package:food_ordering_app/provider/cartProvider.dart';
import 'package:food_ordering_app/views/Checkout.dart';
import 'package:provider/provider.dart';

class CartFloatingButton extends StatelessWidget {
  const CartFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Stack(
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Checkout(),
                  ),
                );
              },
              child: const Icon(Icons.shopping_cart),
            ),
            cartProvider.totalProducts > 0
                ? Positioned(
                    right: 10,
                    top: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 10,
                      child: Text(
                        cartProvider.totalProducts.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
