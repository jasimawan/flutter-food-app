import 'package:flutter/material.dart';
import 'package:food_ordering_app/helper/initialise_data.dart';
import 'package:food_ordering_app/provider/cartProvider.dart';
import 'package:food_ordering_app/views/Home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.initializeDatabase();

  runApp(ChangeNotifierProvider(
    create: (context) => CartProvider(),
    builder: (context, child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        // 'products': (context) => const Products(),
        // 'productDetails': (context) => const ProductDetails(),
        // 'cart': (context) => const Cart(),
        // 'ordersHistory': (context) => const OrdersHistory(),
      },
    ),
  ));
}
