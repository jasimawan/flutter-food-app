import 'package:food_ordering_app/models/product.dart';
import 'package:food_ordering_app/utils/get_database_path.dart';
import 'package:sqflite/sqflite.dart';

class OrderDatabaseHelper {
  static Future<void> createOrder(
      double totalAmount, List<Product> cartList) async {
    if (cartList.isEmpty) {
      return;
    }
    var path = await generateDatabasePath();
    final database = await openDatabase(path, version: 1);

    await database.transaction((txn) async {
      int orderId = await txn.insert(
        'orders',
        {'total_amount': totalAmount, 'order_date': '${DateTime.now()}'},
      );

      for (final cartItem in cartList) {
        await txn.insert(
          'order_items',
          {
            'order_id': orderId,
            'product_id': cartItem.id,
            'product_name': cartItem.name,
            'product_price': cartItem.price,
            'quantity': 1,
          },
        );
      }
    });

    await database.close();
  }
}
