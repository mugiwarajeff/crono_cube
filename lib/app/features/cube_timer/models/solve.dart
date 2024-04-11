import 'dart:ffi';

import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';

class Solve {
  final Int id;
  final double time;
  final DateTime solveDate;
  final String scramble;
  final String comment;
  final CubeType cubeType;

  Solve(
      {required this.id,
      required this.comment,
      required this.time,
      required this.solveDate,
      required this.scramble,
      required this.cubeType});

  Map<String, dynamic> toJson() => {
        "id": id,
        "time": time,
        "solve_date": solveDate.millisecondsSinceEpoch,
        "scramble": scramble,
        "cube_type": cubeType.name,
        "comment": comment
      };

  Solve.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        time = json["time"],
        solveDate = DateTime.fromMillisecondsSinceEpoch(json["solve_date"]),
        scramble = json["scramble"],
        cubeType = CubeType.values.byName(json["cube_type"]),
        comment = json["comment"];
}
