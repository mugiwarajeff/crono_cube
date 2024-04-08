import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
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
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      //await db.execute('CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    });
  }
}
