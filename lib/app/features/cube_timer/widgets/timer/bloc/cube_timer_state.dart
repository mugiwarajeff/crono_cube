import 'package:crono_cube/app/features/cube_timer/enum/timer_states.dart';

abstract class CubeTimerState {}

class InitialCubeTimerState extends CubeTimerState {}

class LoadingCubeTimerState extends CubeTimerState {}

class LoadedCubeTimerState extends CubeTimerState {
  int time;
  int timeCountDown;
  bool pressed;
  bool plusTwo;
  bool dnf;

  TimerState timerState;
  final String scrumble;

  LoadedCubeTimerState(
      {required this.time,
      required this.timeCountDown,
      required this.timerState,
      required this.pressed,
      required this.plusTwo,
      required this.dnf,
      required this.scrumble});
}

class ErrorCubeTimerState extends CubeTimerState {
  String error;

  ErrorCubeTimerState({required this.error});
}
