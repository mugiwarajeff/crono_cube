import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';

class Solve {
  int id;
  final int time;
  final DateTime solveDate;
  final String scramble;
  String comment;
  final CubeType cubeType;
  final CubeTag cubeTag;
  bool dnf;
  bool plusTwo;

  Solve({
    required this.id,
    required this.comment,
    required this.time,
    required this.solveDate,
    required this.scramble,
    required this.cubeTag,
    required this.cubeType,
    required this.dnf,
    required this.plusTwo,
  });

  Map<String, dynamic> toJson() => {
        "time": time,
        "solve_date": solveDate.millisecondsSinceEpoch,
        "scramble": scramble,
        "cube_type": cubeType.name,
        "cube_tag": cubeTag.name,
        "comment": comment,
        "dnf": dnf ? 1 : 0,
        "plus_two": plusTwo ? 1 : 0
      };

  Solve.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        time = json["time"],
        solveDate = DateTime.fromMillisecondsSinceEpoch(json["solve_date"]),
        scramble = json["scramble"],
        cubeTag = CubeTag.values.byName(json["cube_tag"]),
        cubeType = CubeType.values.byName(json["cube_type"]),
        dnf = json["dnf"] == 1 ? true : false,
        plusTwo = json["plus_two"] == 1 ? true : false,
        comment = json["comment"];

  Solve clone() => Solve(
      id: id,
      comment: comment,
      time: time,
      solveDate: solveDate,
      scramble: scramble,
      cubeTag: cubeTag,
      cubeType: cubeType,
      dnf: dnf,
      plusTwo: plusTwo);
}
