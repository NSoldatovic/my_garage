import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_vehicles(id TEXT PRIMARY KEY, brand TEXT,year TEXT,model TEXT, imgUrl TEXT, transmission TEXT, engine TEXT,fuel INTEGER, isFav INTEGER , tires TEXT, mileage TEXT, fuelType TEXT, description TEXT, regDate TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> update(
      String table, Map<String, Object> data, String id) async {
    final db = await DBHelper.database();
    return db.update(table, data, where: ' id=$id');
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<int> delete(String table, String id) async {
    final db = await DBHelper.database();
    return db.delete(table, where: 'id=$id');
  }
}
