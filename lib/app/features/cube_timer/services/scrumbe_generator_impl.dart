import 'dart:math';

import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/services/interfaces/scrumble_generator.dart';

class ScrumbleGeneratorImpl implements ScrumbleGenerator {
  final List<String> possibleMovesFor2x2 = [];
  final List<String> possibleMovesFor3x3 = [
    "F",
    "U",
    "D",
    "R",
    "L",
    "B",
    "F'",
    "U'",
    "D'",
    "R'",
    "L'",
    "B'",
    "F2",
    "U2",
    "D2",
    "R2",
    "L2",
    "B2"
  ];

  final List<String> possibleMovesFor4x4 = [
    "F",
    "U",
    "D",
    "R",
    "L",
    "B",
    "F'",
    "U'",
    "D'",
    "R'",
    "L'",
    "B'",
    "F2",
    "U2",
    "D2",
    "R2",
    "L2",
    "B2",
    "Uw",
    "Dw",
    "Rw",
    "Lw",
    "Fw",
    "Bw",
    "Uw2",
    "Dw2",
    "Rw2",
    "Lw2",
    "Fw2",
    "Bw2",
    "Uw'",
    "Dw'",
    "Rw'",
    "Lw'",
    "Fw'",
    "Bw'",
  ];

  final List<String> possibleMovesFor5x5 = [
    "F",
    "U",
    "D",
    "R",
    "L",
    "B",
    "F'",
    "U'",
    "D'",
    "R'",
    "L'",
    "B'",
    "F2",
    "U2",
    "D2",
    "R2",
    "L2",
    "B2",
    "Uw",
    "Dw",
    "Rw",
    "Lw",
    "Fw",
    "Bw",
    "Uw2",
    "Dw2",
    "Rw2",
    "Lw2",
    "Fw2",
    "Bw2",
    "Uw'",
    "Dw'",
    "Rw'",
    "Lw'",
    "Fw'",
    "Bw'",
  ];

  final List<String> possibleMovesFor6x6 = [
    "F",
    "U",
    "D",
    "R",
    "L",
    "B",
    "F'",
    "U'",
    "D'",
    "R'",
    "L'",
    "B'",
    "F2",
    "U2",
    "D2",
    "R2",
    "L2",
    "B2",
    "Uw",
    "Dw",
    "Rw",
    "Lw",
    "Fw",
    "Bw",
    "Uw2",
    "Dw2",
    "Rw2",
    "Lw2",
    "Fw2",
    "Bw2",
    "Uw'",
    "Dw'",
    "Rw'",
    "Lw'",
    "Fw'",
    "Bw'",
    "3Fw",
    "3Uw",
    "3Dw",
    "3Rw",
    "3Lw",
    "3Bw",
    "3Fw2",
    "3Uw2",
    "3Dw2",
    "3Rw2",
    "3Lw2",
    "3Bw2",
    "3Fw'",
    "3Uw'",
    "3Dw'",
    "3Rw'",
    "3Lw'",
    "3Bw'",
  ];

  final List<String> possibleMovesFor7x7 = [
    "F",
    "U",
    "D",
    "R",
    "L",
    "B",
    "F'",
    "U'",
    "D'",
    "R'",
    "L'",
    "B'",
    "F2",
    "U2",
    "D2",
    "R2",
    "L2",
    "B2",
    "Uw",
    "Dw",
    "Rw",
    "Lw",
    "Fw",
    "Bw",
    "Uw2",
    "Dw2",
    "Rw2",
    "Lw2",
    "Fw2",
    "Bw2",
    "Uw'",
    "Dw'",
    "Rw'",
    "Lw'",
    "Fw'",
    "Bw'",
    "3Fw",
    "3Uw",
    "3Dw",
    "3Rw",
    "3Lw",
    "3Bw",
    "3Fw2",
    "3Uw2",
    "3Dw2",
    "3Rw2",
    "3Lw2",
    "3Bw2",
    "3Fw'",
    "3Uw'",
    "3Dw'",
    "3Rw'",
    "3Lw'",
    "3Bw'",
  ];

  final List<String> possibleMovesForClock = [];

  final List<String> possibleMovesForMegamix = [];

  final List<String> possibleMovesForPiramix = [
    "U",
    "R",
    "L",
    "B",
    "U'",
    "R'",
    "L'",
    "B'",
    "Uw",
    "Rw",
    "Lw",
    "Bw",
    "Uw'",
    "Rw'",
    "Lw'",
    "Bw'",
  ];

  final List<String> possibleMovesForSkweub = [
    "F",
    "U",
    "D",
    "R",
    "L",
    "B",
    "F'",
    "U'",
    "D'",
    "R'",
    "L'",
    "B'"
  ];

  final List<String> possibleMovesForSquare = [];

  @override
  String selectScrumbeForCubeType(CubeType cubeType) {
    switch (cubeType) {
      case CubeType.cube3x3x3:
        return generateScrumble(possibleMovesFor3x3, 20);
      case CubeType.cube2x2x2:
        return generateScrumble(possibleMovesFor2x2, 20);
      case CubeType.cube4x4x4:
        return generateScrumble(possibleMovesFor4x4, 40);
      case CubeType.cube5x5x5:
        return generateScrumble(possibleMovesFor5x5, 60);
      case CubeType.type6x6x6:
        return generateScrumble(possibleMovesFor6x6, 80);
      case CubeType.type7x7x7:
        return generateScrumble(possibleMovesFor7x7, 100);
      case CubeType.rubicclock:
        return generateScrumble(possibleMovesForClock, 20);
      case CubeType.squareone:
        return generateScrumble(possibleMovesForSquare, 20);
      case CubeType.skewb:
        return generateScrumble(possibleMovesForSkweub, 20);
      case CubeType.megamix:
        return generateScrumble(possibleMovesForMegamix, 20);
      case CubeType.pyramix:
        return generateScrumble(possibleMovesForPiramix, 20);
    }
  }

  @override
  String generateScrumble(List<String> possibleMoves, int quantMoves) {
    Random random = Random();

    List<String> scrumble = [];

    for (int i = 0; i < quantMoves; i++) {
      while (true) {
        String move =
            possibleMoves.elementAt(random.nextInt(possibleMoves.length));

        if (scrumble.isEmpty ||
            move != scrumble.last ||
            move.split("")[0] != scrumble.last.split("")[0]) {
          scrumble.add(move);
          break;
        }
      }
    }

    String scrumbleString = scrumble.reduce((value, element) {
      if (scrumble.lastIndexOf(element) == 0) {
        return value += element;
      } else {
        return value += " $element";
      }
    });

    return scrumbleString;
  }
}
