import 'package:crono_cube/app/features/configurations/models/configurations.dart';
import 'package:crono_cube/database/database.dart';
import 'package:sqflite/sqflite.dart';

class ConfigurationsDao {
  static const String tableName = "configurations";
  static const String _darkTheme = "dark_theme";
  static const String _cubeType = "cube_type";
  static const String _cubeTag = "cube_tag";
  static const String _inspect = "inspect";
  static const String _timeInspect = "time_inspect";
  static const String _pressToRun = "press_to_run";

  static const String createTableSql = 'CREATE TABLE $tableName('
      '$_darkTheme INTEGER,'
      '$_inspect INTEGER,'
      '$_timeInspect INTEGER,'
      '$_pressToRun INTEGER,'
      '$_cubeTag TEXT,'
      '$_cubeType TEXT )';

  static const String insertFirstValueSql = 'INSERT INTO $tableName('
      '$_darkTheme,'
      '$_inspect,'
      '$_timeInspect,'
      '$_pressToRun,'
      '$_cubeTag,'
      '$_cubeType )'
      'VALUES ('
      '0,'
      '0,'
      '15,'
      '0,'
      "'normal',"
      "'cube3x3x3')";

  Future<Configurations> getConfigurations() async {
    Database database = await DataBaseHelper.instance;

    Map<String, dynamic> queryResult = (await database.query(tableName)).first;

    Configurations configurations = Configurations.fromJson(queryResult);

    return configurations;
  }

  Future<bool> updateConfigurations(Configurations configurations) async {
    Database database = await DataBaseHelper.instance;

    int result = await database.update(tableName, configurations.toJson());

    if (result > 0) {
      return true;
    }

    return false;
  }
}
