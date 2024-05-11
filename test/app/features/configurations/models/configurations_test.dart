import 'package:crono_cube/app/features/configurations/models/configurations.dart';
import 'package:crono_cube/app/features/configurations/models/value_object/time_inspect.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const Map<String, dynamic> expectedJson = {
    "cube_tag": "normal",
    "cube_type": "cube3x3x3",
    "dark_theme": 1,
    "inspect": 1,
    "press_to_run": 1,
    "time_inspect": 15
  };

  final Configurations expectedConfiguration = Configurations(
      cubeTag: CubeTag.normal,
      cubeType: CubeType.cube3x3x3,
      darkTheme: true,
      inspect: true,
      pressToRun: true,
      timeInspect: TimeInspect(value: 15));

  test("should create a configuration object from a json map", () {
    final Configurations configurations = Configurations.fromJson(expectedJson);

    expect(configurations, equals(expectedConfiguration));
  });

  test("should gererate a json map from configuration object", () {
    Map<String, dynamic> configurationJson = expectedConfiguration.toJson();

    expect(configurationJson, equals(expectedJson));
  });
}
