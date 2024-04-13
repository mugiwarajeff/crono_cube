import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';

abstract class ScrumbleGenerator {
  String selectScrumbeForCubeType(CubeType cubeType);

  String generateScrumble(List<String> possibleMoves, int quantMoves);

  String generateSquareOneScrumbe();
}
