import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/services/interfaces/scrumble_generator.dart';
import 'package:crono_cube/app/features/cube_timer/services/scrumbe_generator_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ScrumbleGenerator scrumbleGenerator;

  setUp(() => scrumbleGenerator = ScrumbleGeneratorImpl());
  test("Should generate a 3x3x3 Scrumble with 20 steps", () {
    int matchLenght = 20;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.cube3x3x3);

    List<String> scrumbleItens = scrumble.split(" ");

    expect(scrumbleItens.length, equals(matchLenght));
  });

  test("Should generate a Square One Scrumble with 10 steps", () {
    int matchLenght = 10;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.squareone);

    print(scrumble);

    List<String> scrumbleItens = scrumble.split("/");

    expect(scrumbleItens.length, equals(matchLenght));
  });

  test("Should generate a Rubick Clock Scrumble with 15 steps", () {
    int matchLenght = 15;
    String scrumble =
        scrumbleGenerator.selectScrumbeForCubeType(CubeType.rubicclock);

    print(scrumble);

    List<String> scrumbleItens = scrumble.split(" ");

    expect(scrumbleItens.length, equals(matchLenght));
  });
}
