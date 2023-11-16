import 'package:flutter/material.dart';
import 'package:food_ordering_app/helper/initialise_data.dart';
import 'package:food_ordering_app/provider/cartProvider.dart';
import 'package:food_ordering_app/views/Checkout.dart';
import 'package:food_ordering_app/views/Home.dart';
import 'package:food_ordering_app/views/OrderDetails.dart';
import 'package:food_ordering_app/views/OrdersHistory.dart';
import 'package:food_ordering_app/views/Products.dart';
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
        '/': (context) => Home(),
        'products': (context) => Products(),
        'checkout': (context) => const Checkout(),
        'ordersHistory': (context) => OrdersHistory(),
        'orderDetails': (context) => OrderDetails()
      },
    ),
  ));
}
