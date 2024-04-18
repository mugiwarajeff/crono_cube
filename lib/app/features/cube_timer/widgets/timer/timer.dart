import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';

import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/enum/timer_states.dart';
import 'package:crono_cube/app/features/cube_timer/models/solve.dart';
import 'package:crono_cube/app/features/cube_timer/utils/timer_utils.dart'
    as utils;

import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_cubit.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_state.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/timer/bloc/cube_timer_bloc.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/timer/bloc/cube_timer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Timer extends StatelessWidget {
  final CubeTag cubeTag;
  final CubeType cubeType;

  const Timer({super.key, required this.cubeTag, required this.cubeType});

  @override
  Widget build(BuildContext context) {
    final SolveListCubit solveListCubit =
        BlocProvider.of<SolveListCubit>(context);
    final ConfigurationsBloc configurationsBloc = BlocProvider.of(context);

    final Size size = MediaQuery.of(context).size;
    const double iconSize = 74;
    const double pressedIconSize = 70;
    const double circleMultFactor = 1.7;
    const double boxRadius = 100;
    const double strokeWidth = 5;
    const double timerTextSize = 80;

    const double averageTextSize = 16;

    final CubeTimerBloc cubeTimerBloc = CubeTimerBloc(
        inspectTime: configurationsBloc.configurations.timeInspect.value);

    return BlocBuilder<CubeTimerBloc, CubeTimerState>(
      bloc: cubeTimerBloc,
      builder: (context, state) {
        if (state is InitialCubeTimerState) {
          return Container();
        } else if (state is LoadingCubeTimerState) {
          return Container();
        } else if (state is LoadedCubeTimerState) {
          return SizedBox(
            height: size.height * 0.4,
            child: Column(
              children: [
                Text(
                  state.dnf
                      ? "DNF"
                      : state.plusTwo
                          ? "+2"
                          : state.timerState == TimerState.inspecting
                              ? state.timeCountDown.toString()
                              : utils.formatCronometerText(state.time),
                  style: TextStyle(
                      fontSize: timerTextSize,
                      color: utils.selectTextColor(state.timerState, context)),
                ),
                BlocBuilder<SolveListCubit, SolveListState>(
                  bloc: solveListCubit,
                  builder: (context, state) {
                    if (state is LoadedSolveListState) {
                      double md5 = 0;
                      double md12 = 0;

                      if (state.solves.length >= 5) {
                        var md5List = state.solves.getRange(
                            state.solves.length - 5, state.solves.length - 1);

                        for (Solve solve in md5List) {
                          md5 += solve.time;
                        }

                        md5 = md5 / md5List.length;
                      }

                      if (state.solves.length >= 12) {
                        var md12List = state.solves.getRange(
                            state.solves.length - 12, state.solves.length - 1);

                        for (Solve solve in md12List) {
                          md12 += solve.time;
                        }

                        md12 = md12 / md12List.length;
                      }
                      return Column(
                        children: [
                          Text(
                              "ao5: ${md5 == 0 ? "--" : (md5 / 1000).toStringAsFixed(2)}",
                              style:
                                  const TextStyle(fontSize: averageTextSize)),
                          Text(
                              "ao12: ${md12 == 0 ? "--" : (md12 / 1000).toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: averageTextSize))
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
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
                  child: GestureDetector(
                    onLongPressStart: (details) {
                      if (configurationsBloc.configurations.pressToRun &&
                          state.timerState == TimerState.initial) {
                        cubeTimerBloc.prepareToGo();
                        cubeTimerBloc.setPressed(true);
                      }
                    },
                    onLongPressEnd: (details) {
                      if (state.timerState == TimerState.ready) {
                        if (configurationsBloc.configurations.inspect) {
                          cubeTimerBloc.startCountDown(context);
                        } else {
                          cubeTimerBloc.startTimer();
                        }
                      } else {
                        cubeTimerBloc.resetCronometer();
                      }
                      cubeTimerBloc.setPressed(false);
                    },
                    onTap: () {
                      if (!configurationsBloc.configurations.pressToRun &&
                          state.timerState == TimerState.initial) {
                        if (configurationsBloc.configurations.inspect) {
                          cubeTimerBloc.startCountDown(context);
                        } else {
                          cubeTimerBloc.startTimer();
                        }
                      } else if (state.timerState == TimerState.inspecting) {
                        cubeTimerBloc.startTimer();
                      } else if (state.timerState == TimerState.running) {
                        cubeTimerBloc.stopTimer(context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: state.pressed
                              ? pressedIconSize * circleMultFactor
                              : iconSize * circleMultFactor,
                          width: state.pressed
                              ? pressedIconSize * circleMultFactor
                              : iconSize * circleMultFactor,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: strokeWidth),
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(boxRadius))),
                          child: Icon(
                            Icons.back_hand_outlined,
                            size: state.pressed ? pressedIconSize : iconSize,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: state.pressed
                              ? pressedIconSize * circleMultFactor
                              : iconSize * circleMultFactor,
                          width: state.pressed
                              ? pressedIconSize * circleMultFactor
                              : iconSize * circleMultFactor,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black, width: strokeWidth),
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(boxRadius))),
                          child: Icon(
                            Icons.back_hand_outlined,
                            size: state.pressed ? pressedIconSize : iconSize,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
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
