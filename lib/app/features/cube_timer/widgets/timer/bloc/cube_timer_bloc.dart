import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/timer/bloc/cube_timer_state.dart';

class CubeTimerBloc extends Cubit<CubeTimerState> {
  int _time = 0;
  bool _running = false;
  DateTime initialTime = DateTime.now();

  CubeTimerBloc() : super(InitialCubeTimerState()) {
    emit(LoadedCubeTimerState(time: _time, running: _running));
  }

  void startTimer() {
    _running = true;
    initialTime = DateTime.now();
    emit(LoadedCubeTimerState(time: _time, running: _running));
    updateTimer();
  }

  Future<void> updateTimer() async {
    if (_running) {
      await Future.delayed(const Duration(milliseconds: 10));
      DateTime nowTime = DateTime.now();
      _time = nowTime.difference(initialTime).inMilliseconds;

      emit(LoadedCubeTimerState(time: _time, running: _running));
      updateTimer();
    }
  }

  void stopTimer() {
    _running = false;
    emit(LoadedCubeTimerState(time: _time, running: _running));
  }
}
