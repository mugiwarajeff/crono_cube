import 'package:crono_cube/app/features/cube_timer/enum/timer_states.dart';
import 'package:crono_cube/app/features/cube_timer/utils/timer_utils.dart'
    as utils;
import 'package:crono_cube/app/features/cube_timer/widgets/timer/bloc/cube_timer_bloc.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/timer/bloc/cube_timer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double iconSize = 74;
    const double pressedIconSize = 70;
    const double circleMultFactor = 1.4;
    const double boxRadius = 50;
    const double strokeWidth = 5;
    const double timerTextSize = 80;

    final CubeTimerBloc cubeTimerBloc = CubeTimerBloc();

    return BlocBuilder<CubeTimerBloc, CubeTimerState>(
      bloc: cubeTimerBloc,
      builder: (context, state) {
        if (state is InitialCubeTimerState) {
          return Container();
        } else if (state is LoadingCubeTimerState) {
          return Container();
        } else if (state is LoadedCubeTimerState) {
          return SizedBox(
            height: size.height * 0.32,
            child: Column(
              children: [
                Text(
                  utils.formatCronometerText(state.time),
                  style: TextStyle(
                      fontSize: timerTextSize,
                      color: utils.selectTextColor(state.timerState)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
                  child: GestureDetector(
                    onLongPressStart: (details) {
                      if (state.timerState == TimerState.initial) {
                        cubeTimerBloc.prepareToGo();
                        cubeTimerBloc.setPressed(true);
                      }
                    },
                    onLongPressEnd: (details) {
                      if (state.timerState == TimerState.ready) {
                        cubeTimerBloc.startTimer();
                      } else {
                        cubeTimerBloc.resetCronometer();
                      }
                      cubeTimerBloc.setPressed(false);
                    },
                    onTap: () {
                      if (state.timerState == TimerState.running) {
                        cubeTimerBloc.stopTimer();
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
                              color: Colors.blue,
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
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(boxRadius))),
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
