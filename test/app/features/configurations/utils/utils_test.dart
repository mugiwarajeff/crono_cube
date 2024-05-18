import 'package:crono_cube/app/features/configurations/utils/utils.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CubeType cube3x3;
  late CubeType cube4x4;
  late CubeType cube5x5;
  late CubeType cube6x6;
  late CubeType cube2x2;
  late CubeType cube7x7;
  late CubeType clock;
  late CubeType squareone;
  late CubeType skewb;
  late CubeType megamix;
  late CubeType piramix;

  late String cube3x3Return;
  late String cube4x4Return;
  late String cube5x5Return;
  late String cube6x6Return;
  late String cube2x2Return;
  late String cube7x7Return;
  late String clockReturn;
  late String squareoneReturn;
  late String skewbReturn;
  late String megamixReturn;
  late String piramixReturn;

  late CubeTag normal;
  late CubeTag blinded;
  late CubeTag foots;
  late CubeTag oneHand;

  late String normalReturn;
  late String blindedReturn;
  late String foortsReturn;
  late String oneHandedReturn;

  setUp(() {
    cube3x3 = CubeType.cube3x3x3;
    cube4x4 = CubeType.cube4x4x4;
    cube2x2 = CubeType.cube2x2x2;
    cube5x5 = CubeType.cube5x5x5;
    cube6x6 = CubeType.type6x6x6;
    cube7x7 = CubeType.type7x7x7;

    clock = CubeType.rubicclock;
    squareone = CubeType.squareone;
    skewb = CubeType.skewb;
    megamix = CubeType.megamix;
    piramix = CubeType.pyramix;

    cube2x2Return = "2x2x2";
    cube3x3Return = "3x3x3";
    cube4x4Return = "4x4x4";
    cube5x5Return = "5x5x5";
    cube6x6Return = "6x6x6";
    cube7x7Return = "7x7x7";
    clockReturn = "Rubiks Clock";
    squareoneReturn = "Square One";
    skewbReturn = "Skewb";
    megamixReturn = "Megamix";
    piramixReturn = "Piramix";

    normal = CubeTag.normal;
    blinded = CubeTag.blind;
    foots = CubeTag.foot;
    oneHand = CubeTag.oneHand;

    normalReturn = "Normal";
    blindedReturn = "Vendado";
    foortsReturn = "Com Pés";
    oneHandedReturn = "Uma Mão";
  });

  test("Should return the correct string with base in CubeType enum", () {
    expect(
        ConfigurationsUtils.translateCubeType(cube2x2), equals(cube2x2Return));
    expect(
        ConfigurationsUtils.translateCubeType(cube3x3), equals(cube3x3Return));

    expect(
        ConfigurationsUtils.translateCubeType(cube4x4), equals(cube4x4Return));
    expect(
        ConfigurationsUtils.translateCubeType(cube5x5), equals(cube5x5Return));
    expect(
        ConfigurationsUtils.translateCubeType(cube6x6), equals(cube6x6Return));
    expect(
        ConfigurationsUtils.translateCubeType(cube7x7), equals(cube7x7Return));

    expect(ConfigurationsUtils.translateCubeType(clock), equals(clockReturn));
    expect(ConfigurationsUtils.translateCubeType(skewb), equals(skewbReturn));
    expect(ConfigurationsUtils.translateCubeType(squareone),
        equals(squareoneReturn));

    expect(
        ConfigurationsUtils.translateCubeType(piramix), equals(piramixReturn));
    expect(
        ConfigurationsUtils.translateCubeType(megamix), equals(megamixReturn));
  });

  test("Should return the correct string with base in CubeTag enum", () {
    expect(ConfigurationsUtils.translateCubeTag(normal), equals(normalReturn));

    expect(
        ConfigurationsUtils.translateCubeTag(blinded), equals(blindedReturn));
    expect(ConfigurationsUtils.translateCubeTag(foots), equals(foortsReturn));
    expect(
        ConfigurationsUtils.translateCubeTag(oneHand), equals(oneHandedReturn));
  });
}
