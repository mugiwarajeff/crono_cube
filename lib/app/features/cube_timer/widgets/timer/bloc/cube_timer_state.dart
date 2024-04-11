import 'package:crono_cube/app/features/cube_timer/enum/timer_states.dart';

abstract class CubeTimerState {}

class InitialCubeTimerState extends CubeTimerState {}

class LoadingCubeTimerState extends CubeTimerState {}

class LoadedCubeTimerState extends CubeTimerState {
  int time;
  bool pressed;
  TimerState timerState;

  LoadedCubeTimerState(
      {required this.time, required this.timerState, required this.pressed});
}

class ErrorCubeTimerState extends CubeTimerState {
  String error;

  ErrorCubeTimerState({required this.error});
}
