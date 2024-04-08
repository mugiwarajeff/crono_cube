abstract class CubeTimerState {}

class InitialCubeTimerState extends CubeTimerState {}

class LoadingCubeTimerState extends CubeTimerState {}

class LoadedCubeTimerState extends CubeTimerState {
  int time;
  bool running;

  LoadedCubeTimerState({required this.time, required this.running});
}

class ErrorCubeTimerState extends CubeTimerState {
  String error;

  ErrorCubeTimerState({required this.error});
}
