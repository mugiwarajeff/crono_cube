import 'dart:math';

import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/services/interfaces/scrumble_generator.dart';

class ScrumbleGeneratorImpl implements ScrumbleGenerator {
  final List<String> possibleMovesFor2x2 = [
    "F",
    "U",
    "R",
    "F'",
    "U'",
    "R'",
    "F2",
    "U2",
    "R2",
  ];
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
    "3Bw'"
  ];

  final List<String> possibleMovesForClock = [
    "UL0",
    "UL1+",
    "UL2+",
    "UL3+",
    "UL4+",
    "UL5+",
    "UL6+",
    "UL1-",
    "UL2-",
    "UL3-",
    "UL4-",
    "UL5-",
    "UL6-",
    "UR0",
    "UR1+",
    "UR1-",
    "UR2+",
    "UR2-",
    "UR3+",
    "UR3-",
    "UR4+",
    "UR4-",
    "UR5+",
    "UR5-",
    "UR6+",
    "UR6-",
    "DL0",
    "DL1+",
    "DL1-",
    "DL2+",
    "DL2-",
    "DL3+",
    "DL3-",
    "DL4+",
    "DL4-",
    "DL5+",
    "DL5-",
    "DL6+",
    "DL6-",
    "DR0",
    "DR1+",
    "DR1-",
    "DR2+",
    "DR2-",
    "DR3+",
    "DR3-",
    "DR4+",
    "DR4-",
    "DR5+",
    "DR5-",
    "DR6+",
    "DR6-",
    "U0",
    "U1+",
    "U1-",
    "U2+",
    "U2-",
    "U3+",
    "U3-",
    "U4+",
    "U4-",
    "U5+",
    "U5-",
    "U6+",
    "U6-",
    "R0",
    "R1+",
    "R1-",
    "R2+",
    "R2-",
    "R3+",
    "R3-",
    "R4+",
    "R4-",
    "R5+",
    "R5-",
    "R6+",
    "R6-",
    "D0",
    "D1+",
    "D1-",
    "D2+",
    "D2-",
    "D3+",
    "D3-",
    "D4+",
    "D4-",
    "D5+",
    "D5-",
    "D6+",
    "D6-",
    "L0",
    "L1+",
    "L1-",
    "L2+",
    "L2-",
    "L3+",
    "L3-",
    "L4+",
    "L4-",
    "L5+",
    "L5-",
    "L6+",
    "L6-",
    "ALL1+",
    "ALL2+",
    "ALL3+",
    "ALL4+",
    "ALL5+",
    "ALL6+",
    "ALL1-",
    "ALL2-",
    "ALL3-",
    "ALL4-",
    "ALL5-",
    "ALL6-",
    "y2"
  ];

  final List<String> possibleMovesForMegamix = [
    "U",
    "U'",
    "R++",
    "R--",
    "L++",
    "L--",
  ];

  final List<String> possibleMovesForPiramix = [
    "U",
    "R",
    "L",
    "B",
    "U'",
    "R'",
    "L'",
    "B'",
    "r",
    "u",
    "b",
    "l",
    "r'",
    "u'",
    "b'",
    "l'",
    "r'",
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
