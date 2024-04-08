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
}
