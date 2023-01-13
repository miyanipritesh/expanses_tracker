import 'package:money_expance/model/budget_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BudgetLocalDatabase {
  static const int _version = 1;
  static const String _dbName = "budget.db";
  static const String tableName = "budget";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, category TEXT NOT NULL, isAlert BOOLEAN, budget TEXT NOT NULL, budgetInPercentage TEXT NOT NULL, witchMonth TEXT NOT NULL )"),
        version: _version);
  }

  // tbl add Budget
  static Future<int> addBudget(Budget budget) async {
    final db = await _getDB();
    final id = await db.insert(tableName, budget.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> updateBudget(Budget budget) async {
    final db = await _getDB();
    return await db.update(tableName, budget.toJson(),
        where: 'id = ?',
        whereArgs: [budget.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteBudget(int id) async {
    final db = await _getDB();
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static deleteDatabase() async {
    final db = await _getDB();
    db.delete(tableName);
  }

  static Future<List<Budget>?> getAllBudget() async {
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    if (maps.isEmpty) {
      return null;
    }
    print('------budget--->$maps');
    return List.generate(maps.length, (index) => Budget.fromJson(maps[index]))
        .reversed
        .toList();
  }
}
