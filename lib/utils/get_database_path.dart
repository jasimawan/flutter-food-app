import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<String> generateDatabasePath() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'my_food_app.db');
  return path;
}
