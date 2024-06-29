import 'package:crono_cube/app/app.dart';
import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:crono_cube/app/features/cube_timer/services/impl/scrumbe_generator_impl.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/scrumble/bloc/scrumble_cubit.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_cubit.dart';
import 'package:crono_cube/app/features/statistics/bloc/statistics_cubit.dart';
import 'package:crono_cube/database/daos/configurations_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    Provider(create: (context) => SolveListCubit()),
    Provider(create: (context) => ConfigurationsDao()),
    ProxyProvider<ConfigurationsDao, ConfigurationsBloc>(
      update: (context, configurationsDao, previous) =>
          ConfigurationsBloc(configurationsDao: configurationsDao),
    ),
    ProxyProvider<ConfigurationsDao, ConfigurationsBloc>(
      lazy: false,
      update: (context, configurationsDao, previous) =>
          ConfigurationsBloc(configurationsDao: configurationsDao),
    ),
    BlocProvider(
      create: (context) =>
          ScrumbleCubit(scrumbleGenerator: ScrumbleGeneratorImpl()),
    ),
    Provider(
      create: (context) => SolveListCubit(),
    ),
    ProxyProvider<SolveListCubit, StatisticsCubit>(
      update: (context, solveListCubit, previous) =>
          StatisticsCubit(solveListCubit: solveListCubit),
    )
  ], child: const App()));
}
