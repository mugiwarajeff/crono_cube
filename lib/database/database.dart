import 'package:crono_cube/database/daos/configurations_dao.dart';
import 'package:crono_cube/database/daos/solve_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static const int _dbVersion = 4;
  static Database? _database;

  static Future<Database> get instance async {
    if (_database == null) {
      await _initDatabase();
    }

    return _database!;
  }

  static Future<void> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cronocuber3.db');

// open the database
    _database = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (Database db, int version) async {
        await db.execute(SolveDao.createTableSql);
        await db.execute(ConfigurationsDao.createTableSql);
        await db.execute(ConfigurationsDao.insertFirstValueSql);
      },
      singleInstance: true,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.delete(SolveDao.tableName);

        await db.delete(ConfigurationsDao.tableName);
      },
    );
  }
}
