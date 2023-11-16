import 'package:flutter/material.dart';
import 'package:food_ordering_app/helper/menu.dart';
import 'package:food_ordering_app/models/product.dart';
import 'package:food_ordering_app/provider/cartProvider.dart';
import 'package:food_ordering_app/widgets/CartFloatingButton.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  final int? categoryId;
  final String? categoryName;

  Products({this.categoryId, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName ?? ""),
      ),
      floatingActionButton: const CartFloatingButton(),
      body: FutureBuilder<List<Product>>(
        future: MenuDatabaseHelper.getProducts(categoryId ?? 0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Products found.'));
          } else {
            List<Product> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.only(bottom: 120),
              itemBuilder: (context, index) {
                return Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.asset(products[index].imageUrl),
                          ListTile(
                            title: Text(
                              products[index].name,
                              style: const TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              'Price: ${products[index].price}',
                              style: const TextStyle(fontSize: 20),
                            ),
                            trailing: Container(
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                                onPressed: () {
                                  cartProvider.addToCart(item: products[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
