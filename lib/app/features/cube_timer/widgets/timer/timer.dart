import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:crono_cube/app/features/configurations/utils/utils.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/enum/timer_states.dart';
import 'package:crono_cube/app/features/cube_timer/utils/timer_utils.dart'
    as utils;
import 'package:crono_cube/app/features/cube_timer/widgets/scrumble/bloc/scrumble_cubit.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_cubit.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/timer/bloc/cube_timer_bloc.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/timer/bloc/cube_timer_state.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/timer/widgets/press_buttons.dart';
import 'package:crono_cube/app/features/statistics/bloc/statistics_cubit.dart';
import 'package:crono_cube/app/features/statistics/bloc/statistics_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Timer extends StatelessWidget {
  final Orientation orientation;
  final CubeTag cubeTag;
  final CubeType cubeType;

  const Timer(
      {super.key,
      required this.cubeTag,
      required this.cubeType,
      required this.orientation});

  @override
  Widget build(BuildContext context) {
    final SolveListCubit solveListCubit =
        BlocProvider.of<SolveListCubit>(context);
    final ScrumbleCubit scrumbleCubit = BlocProvider.of<ScrumbleCubit>(context);
    final ConfigurationsBloc configurationsBloc = Provider.of(context);

    const double timerTextSize = 80;
    const double averageTextSize = 16;
    const double averageLandscapeTextSize = 22;

    final CubeTimerBloc cubeTimerBloc = CubeTimerBloc(
        configurations: configurationsBloc.configurations,
        scrumbleCubit: scrumbleCubit,
        solveListCubit: solveListCubit);

    return BlocConsumer<CubeTimerBloc, CubeTimerState>(
      listener: (context, state) {
        if (state is RecordSolveState) {
          final Color mainColor = Theme.of(context).colorScheme.secondary;
          final String recordText =
              "Novo record para o ${ConfigurationsUtils.translateCubeType(configurationsBloc.configurations.cubeType)}";

          const int messageDuration = 2;

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(recordText),
            duration: const Duration(seconds: messageDuration),
            backgroundColor: mainColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            elevation: 100,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.horizontal,
          ));
        }
      },
      bloc: cubeTimerBloc,
      builder: (context, state) {
        if (state is InitialCubeTimerState) {
          return Container();
        } else if (state is LoadingCubeTimerState) {
          return Container();
        } else if (state is LoadedCubeTimerState) {
          print(state.time);
          return Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      state.timerState == TimerState.dnf
                          ? "DNF"
                          : state.timerState == TimerState.plusTwo
                              ? "+2"
                              : state.timerState == TimerState.inspecting
                                  ? state.timeCountDown.toString()
                                  : utils.formatCronometerText(state.time),
                      style: TextStyle(
                          fontSize: timerTextSize,
                          color: state.wasRecord
                              ? Colors.green
                              : utils.selectTextColor(
                                  state.timerState, context)),
                    ),
                    BlocBuilder<StatisticsCubit, StatisticsState>(
                      builder: (context, state) {
                        if (state is LoadedStatisticsState) {
                          return Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                      "ao5: ${state.ao5 == 0 ? "--" : state.ao5 == -1 ? "DNF" : (state.ao5 / 1000).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontSize: orientation ==
                                                  Orientation.landscape
                                              ? averageLandscapeTextSize
                                              : averageTextSize)),
                                  Text(
                                      "ao12: ${state.ao12 == 0 ? "--" : state.ao12 == -1 ? "DNF" : (state.ao12 / 1000).toStringAsFixed(2)}",
                                      style: TextStyle(
                                          fontSize: orientation ==
                                                  Orientation.landscape
                                              ? averageLandscapeTextSize
                                              : averageTextSize))
                                ],
                              ),
                            ],
                          );
                        } else {
                          return const Column(
                            children: [
                              Text("ao5: --",
                                  style: TextStyle(fontSize: averageTextSize)),
                              Text("ao12: --",
                                  style: TextStyle(fontSize: averageTextSize))
                            ],
                          );
                        }
                      },
                    ),
                    Visibility(
                      visible: orientation == Orientation.portrait,
                      child: PressButtons(
                          cubeTimerBloc: cubeTimerBloc,
                          isPressed: state.pressed,
                          timerState: state.timerState),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: orientation == Orientation.landscape,
                child: PressButtons(
                    cubeTimerBloc: cubeTimerBloc,
                    isPressed: state.pressed,
                    timerState: state.timerState),
              )
            ],
          );
        } else if (state is ErrorCubeTimerState) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }
}
