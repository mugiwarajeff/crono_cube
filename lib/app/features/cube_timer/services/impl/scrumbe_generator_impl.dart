import 'dart:math';

import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/services/impl/possible_moves.dart';
import 'package:crono_cube/app/features/cube_timer/services/interfaces/scrumble_generator.dart';

class ScrumbleGeneratorImpl implements ScrumbleGenerator {
  @override
  String selectScrumbeForCubeType(CubeType cubeType) {
    switch (cubeType) {
      case CubeType.cube3x3x3:
        return generateScrumble(possibleMovesFor3x3, 20);
      case CubeType.cube2x2x2:
        return generateScrumble(possibleMovesFor2x2, 9);
      case CubeType.cube4x4x4:
        return generateScrumble(possibleMovesFor4x4, 40);
      case CubeType.cube5x5x5:
        return generateScrumble(possibleMovesFor5x5, 60);
      case CubeType.type6x6x6:
        return generateScrumble(possibleMovesFor6x6, 80);
      case CubeType.type7x7x7:
        return generateScrumble(possibleMovesFor7x7, 100);
      case CubeType.rubicclock:
        return generateScrumble(possibleMovesForClock, 15);
      case CubeType.squareone:
        return generateSquareOneScrumbe();
      case CubeType.skewb:
        return generateScrumble(possibleMovesForSkweub, 20);
      case CubeType.megamix:
        return generateScrumble(possibleMovesForMegamix, 77);
      case CubeType.pyramix:
        return generateScrumble(possibleMovesForPiramix, 11);
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

  @override
  String generateSquareOneScrumbe() {
    Random random = Random();
    int quantMoves = 10;

    List<String> scrumble = [];

    for (int i = 0; i < quantMoves; i++) {
      while (true) {
        int x = random.nextBool() ? -(random.nextInt(7)) : random.nextInt(7);
        int y = random.nextBool() ? -(random.nextInt(7)) : random.nextInt(7);
        String move = "($x, $y)";

        if (scrumble.isEmpty ||
            move != scrumble.last ||
            move.split("")[0] != scrumble.last.split("")[0] ||
            move != "(0,0)") {
          scrumble.add(move);

          if (i < quantMoves - 1) {
            scrumble.add("/");
          }

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
