import 'package:crono_cube/app/features/configurations/bloc/configuations_state.dart';
import 'package:crono_cube/app/features/configurations/models/configurations.dart';

import 'package:crono_cube/database/daos/configurations_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfigurationsBloc extends Cubit<ConfigurationsState> {
  final ConfigurationsDao _configurationsDao = ConfigurationsDao();
  late Configurations _configurations;

  Configurations get configurations => _configurations;

  ConfigurationsBloc() : super(InitialConfigurationsState()) {
    loadConfigurations();
  }

  Future<void> loadConfigurations() async {
    emit(LoadingConfigurationsState());

    _configurations = await _configurationsDao.getConfigurations();

    emit(LoadedConfigurationsState(
      configurations: _configurations,
    ));
  }

  Future<void> updateConfigurations(Configurations configurations) async {
    bool updateSuccess =
        await _configurationsDao.updateConfigurations(configurations);

    if (updateSuccess) {
      emit(SuccessOnUpdateState(message: "Configurações Atualizadas"));
    }

    loadConfigurations();
  }
}
