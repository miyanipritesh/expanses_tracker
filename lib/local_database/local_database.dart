import 'package:money_expance/model/expanses_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static const int _version = 1;
  static const String _dbName = "expanses.db";
  static const String tableName = "expanses";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, category TEXT NOT NULL, description TEXT NOT NULL, price TEXT NOT NULL, time INTEGER, file TEXT NOT NULL )"),
        version: _version);
  }

  // tbl add Expanses
  static Future<int> addExpanses(Expanses expanses) async {
    final db = await _getDB();
    final id = await db.insert(tableName, expanses.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> updateExpanses(Expanses expanses) async {
    final db = await _getDB();
    return await db.update(tableName, expanses.toJson(),
        where: 'id = ?',
        whereArgs: [expanses.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteExpanses(Expanses expanses) async {
    final db = await _getDB();
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [expanses.id],
    );
  }

  static Future<List<Expanses>?> getAllExpanses() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Expanses.fromJson(maps[index]))
        .reversed
        .toList();
  }
}
