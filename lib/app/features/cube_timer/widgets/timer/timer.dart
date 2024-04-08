import 'package:crono_cube/app/features/cube_timer/widgets/timer/bloc/cube_timer_bloc.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/timer/bloc/cube_timer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    const double iconSize = 64;
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
          return Column(
            children: [
              Text(
                "${(state.time / 1000) < 10 ? "0" : ""}${(state.time / 1000).toStringAsFixed(2)}",
                style: const TextStyle(fontSize: timerTextSize),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
                child: GestureDetector(
                  onTap: () => state.running
                      ? cubeTimerBloc.stopTimer()
                      : cubeTimerBloc.startTimer(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: iconSize * circleMultFactor,
                        width: iconSize * circleMultFactor,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black, width: strokeWidth),
                            color: Colors.blue,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(boxRadius))),
                        child: Icon(
                          Icons.back_hand_outlined,
                          size: iconSize,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: iconSize * circleMultFactor,
                        width: iconSize * circleMultFactor,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black, width: strokeWidth),
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(boxRadius))),
                        child: Icon(
                          Icons.back_hand_outlined,
                          size: iconSize,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
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
