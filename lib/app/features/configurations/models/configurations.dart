import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';

class Configurations {
  final bool darkTheme;
  final bool inspect;
  final bool pressToRun;
  final int timeInspect;

  final CubeTag cubeTag;
  final CubeType cubeType;

  Configurations(
      {required this.cubeTag,
      required this.cubeType,
      required this.darkTheme,
      required this.inspect,
      required this.pressToRun,
      required this.timeInspect});

  Configurations.fromJson(Map<String, dynamic> json)
      : cubeTag = CubeTag.values.byName(json["cube_tag"]),
        cubeType = CubeType.values.byName(json["cube_type"]),
        darkTheme = json["dark_theme"] == 1 ? true : false,
        inspect = json["inspect"] == 1 ? true : false,
        pressToRun = json["press_to_run"] == 1 ? true : false,
        timeInspect = json["time_inspect"];

  Map<String, dynamic> toJson() => {
        "cube_tag": cubeTag.name,
        "cube_type": cubeType.name,
        "dark_theme": darkTheme ? 1 : 0,
        "inspect": inspect ? 1 : 0,
        "press_to_run": pressToRun ? 1 : 0,
        "time_inspect": timeInspect
      };
}
