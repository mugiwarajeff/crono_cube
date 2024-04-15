import 'package:crono_cube/app/features/configurations/models/configurations.dart';

abstract class ConfigurationsState {}

class InitialConfigurationsState extends ConfigurationsState {}

class LoadingConfigurationsState extends ConfigurationsState {}

class LoadedConfigurationsState extends ConfigurationsState {
  Configurations tempConfigurations;
  Configurations configurations;

  LoadedConfigurationsState(
      {required this.configurations, required this.tempConfigurations});
}

class ErrorConfigurationsState extends ConfigurationsState {
  String error;

  ErrorConfigurationsState({required this.error});
}
