import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/services/impl/scrumbe_generator_impl.dart';
import 'package:crono_cube/app/features/cube_timer/services/interfaces/scrumble_generator.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  late ScrumbleGenerator scrumbleGenerator;

  setUp(() => scrumbleGenerator = ScrumbleGeneratorImpl());

  test("Should generate a 2x2x2 Scrumble with 9 steps", () {
    int matchLenght = 9;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.cube2x2x2);

    List<String> scrumbleItens = scrumble.split(" ");

    expect(scrumbleItens.length, equals(matchLenght));
  });
  test("Should generate a 3x3x3 Scrumble with 20 steps", () {
    int matchLenght = 20;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.cube3x3x3);

    List<String> scrumbleItens = scrumble.split(" ");

    expect(scrumbleItens.length, equals(matchLenght));
  });

  test("Should generate a 4x4x4 Scrumble with 40 steps", () {
    int matchLenght = 40;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.cube4x4x4);

    List<String> scrumbleItens = scrumble.split(" ");

    expect(scrumbleItens.length, equals(matchLenght));
  });

  test("Should generate a 5x5x5 Scrumble with 60 steps", () {
    int matchLenght = 60;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.cube5x5x5);

    List<String> scrumbleItens = scrumble.split(" ");

    expect(scrumbleItens.length, equals(matchLenght));
  });

  test("Should generate a 6x6x6 Scrumble with 80 steps", () {
    int matchLenght = 80;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.type6x6x6);

    List<String> scrumbleItens = scrumble.split(" ");

    expect(scrumbleItens.length, equals(matchLenght));
  });

  test("Should generate a 7x7x7 Scrumble with 100 steps", () {
    int matchLenght = 100;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.type7x7x7);

    List<String> scrumbleItens = scrumble.split(" ");

    expect(scrumbleItens.length, equals(matchLenght));
  });

  test("Should generate a Square One Scrumble with 10 steps", () {
    int matchLenght = 10;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.squareone);

    List<String> scrumbleItens = scrumble.split("/");

    expect(scrumbleItens.length, equals(matchLenght));
  });

  test("Should generate a Rubick Clock Scrumble with 15 steps", () {
    int matchLenght = 15;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.rubicclock);

    List<String> scrumbleItens = scrumble.split(" ");

    expect(scrumbleItens.length, equals(matchLenght));
  });

  test("Should generate a Skeub Scrumble with 20 steps", () {
    int matchLenght = 20;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.skewb);

    List<String> scrumbleItens = scrumble.split(" ");

    expect(scrumbleItens.length, equals(matchLenght));
  });
  test("Should generate a megamix Scrumble with 77 steps", () {
    int matchLenght = 77;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.megamix);

    List<String> scrumbleItens = scrumble.split(" ");

    expect(scrumbleItens.length, equals(matchLenght));
  });

  test("Should generate a piramix Scrumble with 11 steps", () {
    int matchLenght = 11;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.pyramix);

    List<String> scrumbleItens = scrumble.split(" ");

    expect(scrumbleItens.length, equals(matchLenght));
  });
}
