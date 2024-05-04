import 'package:crono_cube/app/features/cube_timer/models/solve.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_cubit.dart';
import 'package:crono_cube/app/features/statistics/bloc/statistics_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final SolveListCubit _solveListCubit;

  double _ao5 = 0;
  double _ao12 = 0;

  StatisticsCubit({required SolveListCubit solveListCubit})
      : _solveListCubit = solveListCubit,
        super(InitialStatisticsState()) {
    loadStats();
  }

  void loadStats() {
    emit(LoadingStatisticsState());
    _ao12 = _getAo12();
    _ao5 = _getAo5();

    emit(LoadedStatisticsState(ao12: _ao12, ao5: _ao5));
  }

  double _getAo5() {
    double ao5 = 0;
    if (_solveListCubit.solves.length < 5) {
      return ao5;
    }

    var md5List = _solveListCubit.solves.getRange(
        _solveListCubit.solves.length - 5, _solveListCubit.solves.length);

    for (Solve solve in md5List) {
      if (solve.dnf) {
        ao5 = -1;
        return ao5;
      }

      ao5 += solve.time;
    }

    ao5 = ao5 / md5List.length;

    return ao5;
  }

  double _getAo12() {
    double ao12 = 0;
    if (_solveListCubit.solves.length < 12) {
      return ao12;
    }

    var md5List = _solveListCubit.solves.getRange(
        _solveListCubit.solves.length - 12, _solveListCubit.solves.length);

    for (Solve solve in md5List) {
      if (solve.dnf) {
        ao12 = -1;
        return ao12;
      }

      ao12 += solve.time;
    }

    ao12 = ao12 / md5List.length;

    return ao12;
  }
}
