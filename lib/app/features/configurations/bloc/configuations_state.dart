import 'package:crono_cube/app/features/configurations/models/configurations.dart';

abstract class ConfigurationsState {}

class InitialConfigurationsState extends ConfigurationsState {}

class LoadingConfigurationsState extends ConfigurationsState {}

class LoadedConfigurationsState extends ConfigurationsState {
  Configurations configurations;

  LoadedConfigurationsState({
    required this.configurations,
  });
}

class SuccessOnUpdateState extends ConfigurationsState {
  String message;

  SuccessOnUpdateState({required this.message});
}

class ErrorConfigurationsState extends ConfigurationsState {
  String error;

  ErrorConfigurationsState({required this.error});
}
