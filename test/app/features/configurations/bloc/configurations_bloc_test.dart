import 'package:bloc_test/bloc_test.dart';
import 'package:crono_cube/app/features/configurations/bloc/configuations_state.dart';
import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:crono_cube/app/features/configurations/models/configurations.dart';
import 'package:crono_cube/database/daos/configurations_dao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'configurations_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ConfigurationsDao>()])
void main() {
  late Configurations configurationObjectExpected;
  late ConfigurationsDao configurationsDaoMock;
  late ConfigurationsBloc configurationsBloc;

  setUp(() {
    configurationObjectExpected = Configurations.empty();
    configurationsDaoMock = MockConfigurationsDao();
    configurationsBloc =
        ConfigurationsBloc(configurationsDao: configurationsDaoMock);

    when(configurationsDaoMock.getConfigurations())
        .thenAnswer((realInvocation) async => configurationObjectExpected);

    when(configurationsDaoMock
            .updateConfigurations(configurationObjectExpected))
        .thenAnswer((realInvocation) async => true);
  });

  test("should emit loading state when is created", () {
    expect(configurationsBloc.state, isA<LoadedConfigurationsState>());
  });
  blocTest(
    "should emit loading state and then loaded state when calling loadConfiguration function",
    build: () => configurationsBloc,
    act: (bloc) => bloc.loadConfigurations(),
    expect: () => [
      isInstanceOf<LoadingConfigurationsState>(),
      isInstanceOf<LoadedConfigurationsState>()
    ],
  );

  blocTest(
    "Should update the configurations object and emit SuccessOnUpdateState",
    build: () => configurationsBloc,
    act: (bloc) => bloc.updateConfigurations(configurationObjectExpected),
    //verify: (bloc) => bloc.loadConfigurations(),
    expect: () => [
      isInstanceOf<SuccessOnUpdateState>(),
      isInstanceOf<LoadingConfigurationsState>(),
      isInstanceOf<LoadedConfigurationsState>()
    ],
    verify: (bloc) {
      verify(configurationsDaoMock
              .updateConfigurations(configurationObjectExpected))
          .called(1);
    },
  );

  tearDown(() {
    configurationsBloc.close();
  });
}
