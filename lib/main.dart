import 'package:crono_cube/app/app.dart';
import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:crono_cube/app/features/cube_timer/services/impl/scrumbe_generator_impl.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/scrumble/bloc/scrumble_cubit.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_cubit.dart';
import 'package:crono_cube/app/features/statistics/bloc/statistics_cubit.dart';
import 'package:crono_cube/database/daos/configurations_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final SolveListCubit solveListCubit = SolveListCubit();
  final ConfigurationsDao configurationsDao = ConfigurationsDao();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      lazy: false,
      create: (context) =>
          ConfigurationsBloc(configurationsDao: configurationsDao),
    ),
    BlocProvider(
      create: (context) =>
          ScrumbleCubit(scrumbleGenerator: ScrumbleGeneratorImpl()),
    ),
    BlocProvider(
      create: (context) => solveListCubit,
    ),
    BlocProvider(
      create: (context) => StatisticsCubit(solveListCubit: solveListCubit),
    ),
  ], child: const App()));
}
