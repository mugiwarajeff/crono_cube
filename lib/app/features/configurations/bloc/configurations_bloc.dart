import 'package:crono_cube/app/features/configurations/bloc/configuations_state.dart';
import 'package:crono_cube/app/features/configurations/models/configurations.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/database/daos/configurations_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfigurationsBloc extends Cubit<ConfigurationsState> {
  final ConfigurationsDao _configurationsDao = ConfigurationsDao();
  late Configurations _configurations;
  bool _isReady = false;
  Configurations _tempConfigurations = Configurations.empty();

  ConfigurationsBloc() : super(InitialConfigurationsState()) {
    _loadConfigurations();
  }

  Future<void> _loadConfigurations() async {
    emit(LoadingConfigurationsState());

    _configurations = await _configurationsDao.getConfigurations();
    _tempConfigurations = _configurations.clone();
    _isReady = true;
    emit(LoadedConfigurationsState(
        configurations: _configurations,
        tempConfigurations: _tempConfigurations));
  }

  void initTempConfigurations() {
    // ignore: unnecessary_null_comparison

    if (_isReady) {
      emit(LoadingConfigurationsState());
      _tempConfigurations = _configurations.clone();

      emit(LoadedConfigurationsState(
          configurations: _configurations,
          tempConfigurations: _tempConfigurations));
    }
  }

  void setTempDarkMode(bool newDarkMode) {
    _tempConfigurations.darkTheme = newDarkMode;
    emit(LoadedConfigurationsState(
        configurations: _configurations,
        tempConfigurations: _tempConfigurations));
  }

  void setTempInspect(bool newInspect) {
    _tempConfigurations.inspect = newInspect;
    emit(LoadedConfigurationsState(
        configurations: _configurations,
        tempConfigurations: _tempConfigurations));
  }

  void setTempPressToRun(bool newPressToRun) {
    _tempConfigurations.pressToRun = newPressToRun;
    emit(LoadedConfigurationsState(
        configurations: _configurations,
        tempConfigurations: _tempConfigurations));
  }

  void setCubeType(CubeType cubeType) {
    _tempConfigurations.cubeType = cubeType;
    emit(LoadedConfigurationsState(
        configurations: _configurations,
        tempConfigurations: _tempConfigurations));
  }

  void setCubeTag(CubeTag cubeTag) {
    _tempConfigurations.cubeTag = cubeTag;
    emit(LoadedConfigurationsState(
        configurations: _configurations,
        tempConfigurations: _tempConfigurations));
  }

  Future<bool> updateConfigurations(Configurations configurations) async {
    bool updateSuccess =
        await _configurationsDao.updateConfigurations(configurations);

    await _loadConfigurations();

    return updateSuccess;
  }
}
