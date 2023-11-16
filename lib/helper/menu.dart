import 'package:food_ordering_app/models/category.dart';
import 'package:food_ordering_app/models/product.dart';
import 'package:food_ordering_app/utils/get_database_path.dart';
import 'package:sqflite/sqflite.dart';

class MenuDatabaseHelper {
  static Future<List<Category>> getCategories() async {
    var path = await generateDatabasePath();
    final Database database = await openDatabase(path);

    final List<Map<String, dynamic>> categoryMaps =
        await database.query('categories');

    await database.close();

    return List.generate(categoryMaps.length, (i) {
      return Category(
        id: categoryMaps[i]['id'],
        name: categoryMaps[i]['name'],
      );
    });
  }

  static Future<List<Product>> getProducts() async {
    var path = await generateDatabasePath();
    final Database database = await openDatabase(path);

    final List<Map<String, dynamic>> productMaps =
        await database.query('products');

    await database.close();

    return List.generate(productMaps.length, (i) {
      return Product(
          id: productMaps[i]['id'],
          name: productMaps[i]['name'],
          categoryId: productMaps[i]['category_id'],
          imageUrl: productMaps[i]['image_url'],
          price: productMaps[i]['price']);
    });
  }
}
