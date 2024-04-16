import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';

class Solve {
  int id;
  final int time;
  final DateTime solveDate;
  final String scramble;
  final String comment;
  final CubeType cubeType;
  final CubeTag cubeTag;

  Solve(
      {required this.id,
      required this.comment,
      required this.time,
      required this.solveDate,
      required this.scramble,
      required this.cubeTag,
      required this.cubeType});

  Map<String, dynamic> toJson() => {
        "time": time,
        "solve_date": solveDate.millisecondsSinceEpoch,
        "scramble": scramble,
        "cube_type": cubeType.name,
        "cube_tag": cubeTag.name,
        "comment": comment
      };

  Solve.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        time = json["time"],
        solveDate = DateTime.fromMillisecondsSinceEpoch(json["solve_date"]),
        scramble = json["scramble"],
        cubeTag = CubeTag.values.byName(json["cube_tag"]),
        cubeType = CubeType.values.byName(json["cube_type"]),
        comment = json["comment"];
}
