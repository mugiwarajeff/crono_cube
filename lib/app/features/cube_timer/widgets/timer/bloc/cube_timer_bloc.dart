import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/enum/timer_states.dart';
import 'package:crono_cube/app/features/cube_timer/models/solve.dart';
import 'package:crono_cube/app/features/cube_timer/services/impl/scrumbe_generator_impl.dart';
import 'package:crono_cube/app/features/cube_timer/services/interfaces/scrumble_generator.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/scrumble/bloc/scrumble_cubit.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_cubit.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/timer/bloc/cube_timer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubeTimerBloc extends Cubit<CubeTimerState> {
  final int _awaitHoldinTime = 1000;
  int _time = 0;
  final inspectTime;
  int _countDownTime;
  int _holdingTime = 0;
  String _scrumble = "";
  bool _plusTwo = false;
  bool _dnf = false;

  bool _pressed = false;
  TimerState _timerState = TimerState.initial;

  DateTime initialTime = DateTime.now();
  DateTime countDownTime = DateTime.now();

  CubeTimerBloc({required this.inspectTime})
      : _countDownTime = inspectTime,
        super(InitialCubeTimerState()) {
    _loadTimer();
  }

  void _loadTimer() {
    ScrumbleGenerator scrumbleGenerator = ScrumbleGeneratorImpl();
    _scrumble = scrumbleGenerator.selectScrumbeForCubeType(CubeType.cube3x3x3);
    emit(LoadedCubeTimerState(
        time: _time,
        timeCountDown: _countDownTime,
        timerState: _timerState,
        pressed: _pressed,
        dnf: _dnf,
        plusTwo: _plusTwo,
        scrumble: _scrumble));
  }

  void prepareToGo() {
    resetCronometer();
    _timerState = TimerState.preparing;

    _updateHoldingTime();
    emit(LoadedCubeTimerState(
        time: _time,
        timeCountDown: _countDownTime,
        timerState: _timerState,
        pressed: _pressed,
        dnf: _dnf,
        plusTwo: _plusTwo,
        scrumble: _scrumble));
  }

  void startCountDown(BuildContext context) {
    _timerState = TimerState.inspecting;
    _countDownTime = inspectTime;
    countDownTime = DateTime.now();

    emit(LoadedCubeTimerState(
        time: _time,
        timeCountDown: _countDownTime,
        timerState: _timerState,
        pressed: _pressed,
        dnf: _dnf,
        plusTwo: _plusTwo,
        scrumble: _scrumble));
    _updateCountDown(context);
  }

  Future<void> _updateCountDown(BuildContext context) async {
    if (_plusTwo) {
      _dnf = true;
      emit(LoadedCubeTimerState(
          time: _time,
          timeCountDown: _countDownTime,
          timerState: _timerState,
          pressed: _pressed,
          dnf: _dnf,
          plusTwo: _plusTwo,
          scrumble: _scrumble));

      stopTimer(context);
    } else if (_countDownTime == 0) {
      _plusTwo = true;
      emit(LoadedCubeTimerState(
          time: _time,
          timeCountDown: _countDownTime,
          timerState: _timerState,
          pressed: _pressed,
          dnf: _dnf,
          plusTwo: _plusTwo,
          scrumble: _scrumble));

      await Future.delayed(const Duration(seconds: 2));
      _updateCountDown(context);
    } else if (_timerState == TimerState.inspecting && _countDownTime > 0) {
      await Future.delayed(const Duration(milliseconds: 1000));

      _countDownTime -= 1;

      emit(LoadedCubeTimerState(
          time: _time,
          timeCountDown: _countDownTime,
          timerState: _timerState,
          pressed: _pressed,
          dnf: _dnf,
          plusTwo: _plusTwo,
          scrumble: _scrumble));

      _updateCountDown(context);
    }
  }

  void _readyToGo() {
    _timerState = TimerState.ready;
    emit(LoadedCubeTimerState(
        time: _time,
        timerState: _timerState,
        dnf: _dnf,
        plusTwo: _plusTwo,
        pressed: _pressed,
        timeCountDown: _countDownTime,
        scrumble: _scrumble));
  }

  void resetCronometer() {
    _timerState = TimerState.initial;
    _time = 0;
    _countDownTime = inspectTime;
    _dnf = false;
    _plusTwo = false;
    emit(LoadedCubeTimerState(
        dnf: _dnf,
        plusTwo: _plusTwo,
        time: _time,
        timerState: _timerState,
        timeCountDown: _countDownTime,
        pressed: _pressed,
        scrumble: _scrumble));
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
    _time = 0;
    initialTime = DateTime.now();
    emit(LoadedCubeTimerState(
        time: _time,
        dnf: _dnf,
        plusTwo: _plusTwo,
        timerState: _timerState,
        pressed: _pressed,
        timeCountDown: _countDownTime,
        scrumble: _scrumble));
    updateTimer();
  }

  void setPressed(bool pressed) {
    _pressed = pressed;
    emit(LoadedCubeTimerState(
        time: _time,
        dnf: _dnf,
        plusTwo: _plusTwo,
        timerState: _timerState,
        pressed: _pressed,
        timeCountDown: _countDownTime,
        scrumble: _scrumble));
  }

  Future<void> updateTimer() async {
    if (_timerState == TimerState.running) {
      await Future.delayed(const Duration(milliseconds: 10));
      DateTime nowTime = DateTime.now();
      _time = nowTime.difference(initialTime).inMilliseconds;

      emit(LoadedCubeTimerState(
          time: _time,
          dnf: _dnf,
          plusTwo: _plusTwo,
          timerState: _timerState,
          timeCountDown: _countDownTime,
          pressed: _pressed,
          scrumble: _scrumble));
      updateTimer();
    }
  }

  void stopTimer(BuildContext context) {
    SolveListCubit solveListCubit =
        BlocProvider.of<SolveListCubit>(context, listen: false);
    ScrumbleCubit scrumbleCubit = BlocProvider.of<ScrumbleCubit>(context);

    ConfigurationsBloc configurationsCubit =
        BlocProvider.of<ConfigurationsBloc>(context);
    _timerState = TimerState.initial;
    _holdingTime = 0;

    emit(LoadedCubeTimerState(
        time: _time,
        timeCountDown: _countDownTime,
        dnf: _dnf,
        plusTwo: _plusTwo,
        timerState: _timerState,
        pressed: _pressed,
        scrumble: _scrumble));

    solveListCubit.addNewSolve(Solve(
        id: 0,
        comment: "",
        time: _time,
        solveDate: DateTime.now(),
        scramble: scrumbleCubit.scrumble,
        cubeTag: configurationsCubit.configurations.cubeTag,
        cubeType: configurationsCubit.configurations.cubeType,
        dnf: false,
        plusTwo: false));

    scrumbleCubit.resetScramble();
  }
}
