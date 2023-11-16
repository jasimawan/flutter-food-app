import 'package:food_ordering_app/models/order.dart';
import 'package:food_ordering_app/models/product.dart';
import 'package:food_ordering_app/utils/get_database_path.dart';
import 'package:sqflite/sqflite.dart';

class OrderDatabaseHelper {
  static Future<List<Order>> getOrders() async {
    var path = await generateDatabasePath();
    final Database database = await openDatabase(path);

    final List<Map<String, dynamic>> ordersMaps =
        await database.query('orders');

    await database.close();

    return List.generate(ordersMaps.length, (i) {
      return Order(
          id: ordersMaps[i]['id'],
          totalAmount: ordersMaps[i]['total_amount'],
          dateTime: DateTime.parse(ordersMaps[i]['order_date']));
    });
  }

  static Future<List<OrderItem>> getOrderItems(int orderId) async {
    var path = await generateDatabasePath();
    final Database database = await openDatabase(path);

    final List<Map<String, dynamic>> ordersItemsMaps = await database
        .query('order_items', where: 'order_id = ?', whereArgs: [orderId]);

    await database.close();

    return List.generate(ordersItemsMaps.length, (i) {
      return OrderItem(
          id: ordersItemsMaps[i]['id'],
          orderId: ordersItemsMaps[i]['order_id'],
          productId: ordersItemsMaps[i]['product_id'],
          productName: ordersItemsMaps[i]['product_name'],
          productPrice: ordersItemsMaps[i]['product_price'],
          quantity: ordersItemsMaps[i]['quantity'],
          productImage: ordersItemsMaps[i]['product_image']);
    });
  }

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
            'product_image': cartItem.imageUrl,
            'quantity': 1,
          },
        );
      }
    });

    await database.close();
  }
}
