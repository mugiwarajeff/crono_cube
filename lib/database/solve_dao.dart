import 'package:crono_cube/app/features/cube_timer/models/solve.dart';
import 'package:crono_cube/database/database.dart';
import 'package:sqflite/sqflite.dart';

class SolveDao {
  static const String tableName = "solves";
  static const String _id = "id";
  static const String _time = "time";
  static const String _solveDate = "solve_date";
  static const String _scramble = "scramble";
  static const String _comment = "comment";
  static const String _cubeType = "cube_type";

  static const String createTableSql = 'CREATE TABLE $tableName('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$_time REAL,'
      '$_solveDate INTEGER,'
      '$_scramble TEXT,'
      '$_comment TEXT,'
      '$_cubeType TEXT )';

  Future<int> insertSolve(Solve solve) async {
    Database db = await DataBaseHelper.instance;

    int newId = await db.insert(tableName, solve.toJson());

    return newId;
  }

  Future<List<Solve>> getAllSolves() async {
    Database db = await DataBaseHelper.instance;

    List<Map<String, dynamic>> queryResult = await db.query(tableName);

    List<Solve> solves =
        queryResult.map((solveJson) => Solve.fromJson(solveJson)).toList();

    return solves;
  }
}
