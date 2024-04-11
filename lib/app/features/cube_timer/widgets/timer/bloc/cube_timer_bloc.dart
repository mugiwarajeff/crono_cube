import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crono_cube/app/features/cube_timer/enum/timer_states.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/timer/bloc/cube_timer_state.dart';

class CubeTimerBloc extends Cubit<CubeTimerState> {
  int _time = 0;
  int _holdingTime = 0;
  final int _awaitHoldinTime = 1000;
  bool _pressed = false;
  TimerState _timerState = TimerState.initial;

  DateTime initialTime = DateTime.now();

  CubeTimerBloc() : super(InitialCubeTimerState()) {
    emit(LoadedCubeTimerState(
        time: _time, timerState: _timerState, pressed: _pressed));
  }

  void prepareToGo() {
    _timerState = TimerState.preparing;
    _time = 0;
    _updateHoldingTime();
    emit(LoadedCubeTimerState(
        time: _time, timerState: _timerState, pressed: _pressed));
  }

  void _readyToGo() {
    _timerState = TimerState.ready;
    emit(LoadedCubeTimerState(
        time: _time, timerState: _timerState, pressed: _pressed));
  }

  void resetCronometer() {
    _timerState = TimerState.initial;
    _holdingTime = 0;
    emit(LoadedCubeTimerState(
        time: _time, timerState: _timerState, pressed: _pressed));
  }

  Future<void> _updateHoldingTime() async {
    if (_timerState == TimerState.preparing) {
      await Future.delayed(const Duration(milliseconds: 100));

      _holdingTime += 100;

      if (_holdingTime == _awaitHoldinTime) {
        _readyToGo();
      }

      await _updateHoldingTime();
    }
  }

  void startTimer() {
    _timerState = TimerState.running;
    initialTime = DateTime.now();
    emit(LoadedCubeTimerState(
        time: _time, timerState: _timerState, pressed: _pressed));
    updateTimer();
  }

  void setPressed(bool pressed) {
    _pressed = pressed;
    emit(LoadedCubeTimerState(
        time: _time, timerState: _timerState, pressed: _pressed));
  }

  Future<void> updateTimer() async {
    if (_timerState == TimerState.running) {
      await Future.delayed(const Duration(milliseconds: 10));
      DateTime nowTime = DateTime.now();
      _time = nowTime.difference(initialTime).inMilliseconds;

      emit(LoadedCubeTimerState(
          time: _time, timerState: _timerState, pressed: _pressed));
      updateTimer();
    }
  }

  void stopTimer() {
    _timerState = TimerState.initial;
    _holdingTime = 0;
    emit(LoadedCubeTimerState(
        time: _time, timerState: _timerState, pressed: _pressed));
  }
}
