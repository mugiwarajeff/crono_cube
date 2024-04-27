import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/enum/timer_states.dart';
import 'package:crono_cube/app/features/cube_timer/models/solve.dart';
import 'package:crono_cube/app/features/cube_timer/services/impl/scrumbe_generator_impl.dart';
import 'package:crono_cube/app/features/cube_timer/services/interfaces/scrumble_generator.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/scrumble/bloc/scrumble_cubit.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_cubit.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/timer/bloc/cube_timer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock/wakelock.dart';
import '../../../../configurations/models/configurations.dart';

class CubeTimerBloc extends Cubit<CubeTimerState> {
  final Configurations _configurations;
  final ScrumbleCubit scrumbleCubit;
  final SolveListCubit solveListCubit;
  final int _awaitHoldinTime = 1000;
  int _time = 0;
  final int _inspectTime;
  int _inspectionTime;
  int _holdingTime = 0;
  String _scrumble = "";
  bool _plusTwo = false;
  bool _dnf = false;

  bool _pressed = false;
  TimerState _timerState = TimerState.initial;

  DateTime initialTime = DateTime.now();
  DateTime initialInspectionDateTime = DateTime.now();

  CubeTimerBloc(
      {required Configurations configurations,
      required this.solveListCubit,
      required this.scrumbleCubit})
      : _configurations = configurations,
        _inspectTime = configurations.timeInspect.value,
        _inspectionTime = configurations.timeInspect.value,
        super(InitialCubeTimerState()) {
    _loadTimer();
  }

  void _loadTimer() {
    ScrumbleGenerator scrumbleGenerator = ScrumbleGeneratorImpl();
    _scrumble = scrumbleGenerator.selectScrumbeForCubeType(CubeType.cube3x3x3);
    emit(LoadedCubeTimerState(
      time: _time,
      timeCountDown: _inspectionTime,
      timerState: _timerState,
      pressed: _pressed,
      dnf: _dnf,
      plusTwo: _plusTwo,
      scrumble: _scrumble,
    ));
  }

  void prepareToGo() {
    if (!_configurations.pressToRun) {
      return;
    }

    _timerState = TimerState.preparing;

    _updateHoldingTime();
    emit(LoadedCubeTimerState(
        time: _time,
        timeCountDown: _inspectionTime,
        timerState: _timerState,
        pressed: _pressed,
        dnf: _dnf,
        plusTwo: _plusTwo,
        scrumble: _scrumble));
  }

  void startInpection() {
    _timerState = TimerState.inspecting;
    initialInspectionDateTime = DateTime.now();

    emit(LoadedCubeTimerState(
        time: _time,
        timeCountDown: _inspectionTime,
        timerState: _timerState,
        pressed: _pressed,
        dnf: _dnf,
        plusTwo: _plusTwo,
        scrumble: _scrumble));

    _updateInspectionTime();
  }

  Future<void> _updateInspectionTime() async {
    if (_timerState == TimerState.plusTwo) {
      _dnf = true;
      _timerState = TimerState.dnf;
      emit(LoadedCubeTimerState(
          time: _time,
          timeCountDown: _inspectionTime,
          timerState: _timerState,
          pressed: _pressed,
          dnf: _dnf,
          plusTwo: _plusTwo,
          scrumble: _scrumble));

      stopTimer();
    } else if (_inspectionTime == 0) {
      _plusTwo = true;
      _inspectionTime = 15;
      _timerState = TimerState.plusTwo;

      emit(LoadedCubeTimerState(
          time: _time,
          timeCountDown: _inspectionTime,
          timerState: _timerState,
          pressed: _pressed,
          dnf: _dnf,
          plusTwo: _plusTwo,
          scrumble: _scrumble));

      await Future.delayed(const Duration(seconds: 2));
      _updateInspectionTime();
    } else if (_timerState == TimerState.inspecting && _inspectionTime > 0) {
      await Future.delayed(const Duration(milliseconds: 1000));

      _inspectionTime -= 1;

      emit(LoadedCubeTimerState(
          time: _time,
          timeCountDown: _inspectionTime,
          timerState: _timerState,
          pressed: _pressed,
          dnf: _dnf,
          plusTwo: _plusTwo,
          scrumble: _scrumble));

      _updateInspectionTime();
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
        timeCountDown: _inspectionTime,
        scrumble: _scrumble));
  }

  void verifyPressedTimeCanGo() {
    if (_timerState == TimerState.ready) {
      startTimer();
      return;
    }

    _resetCronometer();
  }

  void _resetCronometer() {
    _timerState = _dnf ? TimerState.dnf : TimerState.initial;
    _time = 0;
    _holdingTime = 0;
    _inspectionTime = _inspectTime;
    _dnf = false;
    _plusTwo = false;

    emit(LoadedCubeTimerState(
        dnf: _dnf,
        plusTwo: _plusTwo,
        time: _time,
        timerState: _timerState,
        timeCountDown: _inspectionTime,
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
    if (_configurations.pressToRun && _timerState == TimerState.initial) {
      return;
    }

    if (_timerState == TimerState.running ||
        _timerState == TimerState.preparing) {
      return;
    }

    if (_configurations.inspect &&
        (_timerState == TimerState.initial ||
            _timerState == TimerState.dnf ||
            _timerState == TimerState.ready)) {
      startInpection();
      return;
    }

    _timerState = TimerState.running;
    Wakelock.enable();
    emit(LoadedCubeTimerState(
        time: _time,
        dnf: _dnf,
        plusTwo: _plusTwo,
        timerState: _timerState,
        pressed: _pressed,
        timeCountDown: _inspectionTime,
        scrumble: _scrumble));
    _updateTimer();
  }

  void setPressed(bool pressed) {
    _pressed = pressed;
    emit(LoadedCubeTimerState(
        time: _time,
        dnf: _dnf,
        plusTwo: _plusTwo,
        timerState: _timerState,
        pressed: _pressed,
        timeCountDown: _inspectionTime,
        scrumble: _scrumble));
  }

  Future<void> _updateTimer() async {
    if (_timerState == TimerState.running) {
      await Future.delayed(const Duration(milliseconds: 10));
      DateTime nowTime = DateTime.now();
      _time = nowTime.difference(initialTime).inMilliseconds;

      emit(LoadedCubeTimerState(
          time: _time,
          dnf: _dnf,
          plusTwo: _plusTwo,
          timerState: _timerState,
          timeCountDown: _inspectionTime,
          pressed: _pressed,
          scrumble: _scrumble));
      _updateTimer();
    }
  }

  void stopTimer() {
    emit(LoadedCubeTimerState(
        time: _time,
        timeCountDown: _inspectionTime,
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
        cubeTag: _configurations.cubeTag,
        cubeType: _configurations.cubeType,
        dnf: _dnf,
        plusTwo: _plusTwo));

    _resetCronometer();
    scrumbleCubit.resetScramble();
    Wakelock.disable();
  }
}
