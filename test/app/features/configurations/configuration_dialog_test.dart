import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:crono_cube/app/features/configurations/configurations_dialog.dart';
import 'package:crono_cube/app/features/configurations/models/configurations.dart';
import 'package:crono_cube/database/daos/configurations_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'configuration_dialog_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ConfigurationsDao>()])
void main() {
  late Configurations baseConfiguration;
  late ConfigurationsBloc configurationsBloc;
  late ConfigurationsDao configurationsDaoMock;

  setUpAll(() {
    baseConfiguration = Configurations.empty();
    configurationsDaoMock = MockConfigurationsDao();

    when(configurationsDaoMock.getConfigurations())
        .thenAnswer((realInvocation) async => baseConfiguration);

    configurationsBloc =
        ConfigurationsBloc(configurationsDao: configurationsDaoMock);
  });
  testWidgets("should present a dialog in screen", (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: ConfigurationsDialog(configurationsBloc: configurationsBloc),
    )));

    await widgetTester.pumpAndSettle(const Duration(seconds: 2));
    Finder dialogFinder =
        find.byElementPredicate((element) => element is BlocConsumer);

    expect(dialogFinder, findsOneWidget);
  });

  tearDownAll(() => configurationsBloc.close());
}
