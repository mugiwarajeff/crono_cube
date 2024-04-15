import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';

class ConfigurationsUtils {
  static String translateCubeType(CubeType cubeType) {
    switch (cubeType) {
      case CubeType.cube3x3x3:
        return "3x3x3";
      case CubeType.cube2x2x2:
        return "2x2x2";
      case CubeType.cube4x4x4:
        return "4x4x4";
      case CubeType.cube5x5x5:
        return "5x5x5";
      case CubeType.type6x6x6:
        return "6x6x6";
      case CubeType.type7x7x7:
        return "7x7x7";
      case CubeType.rubicclock:
        return "Rubiks Clock";
      case CubeType.squareone:
        return "Square One";
      case CubeType.skewb:
        return "Skewb";
      case CubeType.megamix:
        return "Megamix";
      case CubeType.pyramix:
        return "Piramix";
    }
  }

  static String translateCubeTag(CubeTag cubeTag) {
    switch (cubeTag) {
      case CubeTag.normal:
        return "Normal";
      case CubeTag.blind:
        return "Vendado";
      case CubeTag.foot:
        return "Com Pés";
      case CubeTag.oneHand:
        return "Uma Mão";
    }
  }
}
