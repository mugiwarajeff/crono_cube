import 'package:crono_cube/database/solve_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static const int _dbVersion = 1;
  static Database? _database;

  static Future<Database> get instance async {
    if (_database == null) {
      await _initDatabase();
    }

    return _database!;
  }

  static Future<void> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cronocuber.db');

// open the database
    _database = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (Database db, int version) async {
        await db.execute(SolveDao.createTableSql);
      },
      singleInstance: true,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.delete(SolveDao.tableName);
      },
    );
  }
}
