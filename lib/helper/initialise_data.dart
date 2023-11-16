import 'package:food_ordering_app/data/data.dart';
import 'package:food_ordering_app/utils/get_database_path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<void> initializeDatabase() async {
    var path = await generateDatabasePath();

    await deleteDatabase(path);

    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, image TEXT)',
        );
        db.execute(
          'CREATE TABLE products(id INTEGER PRIMARY KEY, category_id INTEGER, name TEXT, price REAL, description TEXT, image_url TEXT)',
        );
        db.execute(
          'CREATE TABLE orders(id INTEGER PRIMARY KEY AUTOINCREMENT, total_amount REAL, order_date TEXT)',
        );
        db.execute(
          'CREATE TABLE order_items(id INTEGER PRIMARY KEY AUTOINCREMENT, order_id INTEGER, product_id INTEGER, product_name TEXT, product_price REAL, product_image TEXT, quantity INTEGER)',
        );
      },
    );

    await _initializeCategories(database);
    await _initializeProducts(database);

    await database.close();
  }

  static Future<void> _initializeCategories(Database database) async {
    await database.insert(
        'categories', {'name': 'Burgers', 'image': 'asset/chicken_burger.png'});
    await database.insert(
        'categories', {'name': 'Cold Drinks', 'image': 'asset/coke.png'});
    await database
        .insert('categories', {'name': 'Fries', 'image': 'asset/fries.png'});
  }

  static Future<void> _initializeProducts(Database database) async {
    for (final product in menuList) {
      await database.insert('products', {
        'category_id': product['categoryId'],
        'name': product['name'],
        'price': product['price'],
        'image_url': product['image'],
      });
    }
  }
}
