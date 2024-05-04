import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
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
  static const String _cubeTag = "cube_tag";
  static const String _dnf = "dnf";
  static const String _plusTwo = "plus_two";

  static const String createTableSql = 'CREATE TABLE $tableName('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$_time INTEGER,'
      '$_solveDate INTEGER,'
      '$_scramble TEXT,'
      '$_comment TEXT,'
      '$_cubeTag TEXT,'
      '$_dnf INTEGER,'
      '$_plusTwo INTEGER,'
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

  Future<List<Solve>> getSolvesByCubeType(
      CubeType cubeType, CubeTag cubeTag) async {
    Database db = await DataBaseHelper.instance;

    List<Map<String, dynamic>> queryResult = await db.query(tableName,
        where:
            "$_cubeType = '${cubeType.name}' and $_cubeTag = '${cubeTag.name}'");

    List<Solve> solves =
        queryResult.map((solveJson) => Solve.fromJson(solveJson)).toList();

    return solves;
  }

  Future<int> deleteSolve(Solve solve) async {
    Database db = await DataBaseHelper.instance;

    int result = await db.delete(tableName, where: "$_id = '${solve.id}'");

    return result;
  }

  Future<int> updateSolve(Solve solve) async {
    Database db = await DataBaseHelper.instance;

    int result = await db.update(tableName, solve.toJson(),
        where: "$_id = '${solve.id}'");

    return result;
  }
}
