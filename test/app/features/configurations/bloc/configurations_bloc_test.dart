import 'package:bloc_test/bloc_test.dart';
import 'package:crono_cube/app/features/configurations/bloc/configuations_state.dart';
import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:crono_cube/app/features/configurations/models/configurations.dart';
import 'package:crono_cube/database/daos/configurations_dao.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'configurations_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ConfigurationsDao>()])
void main() {
  ConfigurationsDao configurationsDaoMock = MockConfigurationsDao();

  ConfigurationsBloc configurationsBloc =
      ConfigurationsBloc(configurationsDao: configurationsDaoMock);

  when(configurationsDaoMock.getConfigurations())
      .thenAnswer((realInvocation) async => Configurations.empty());
  blocTest(
    "should emit loading state when is created",
    build: () => configurationsBloc,
    act: (bloc) => bloc.loadConfigurations(),
    wait: const Duration(seconds: 2),
    expect: () => LoadingConfigurationsState(),
  );
}
