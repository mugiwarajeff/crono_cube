import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_cubit.dart';
import 'package:crono_cube/app/features/statistics/bloc/statistics_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final SolveListCubit _solveListCubit;

  double ao5 = 0;
  double ao12 = 0;

  StatisticsCubit({required SolveListCubit solveListCubit})
      : _solveListCubit = solveListCubit,
        super(InitialStatisticsState());
}
