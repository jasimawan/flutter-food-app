import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> cartList = [];

  get totalProducts => cartList.length;

  get totalPrice {
    double price = 0;
    for (Product item in cartList) {
      price += item.price;
    }
    return price;
  }

  void addToCart({required Product item}) {
    cartList.add(item);
    notifyListeners();
  }

  void emptyCart() {
    cartList = [];
    notifyListeners();
  }
}
