import 'package:crono_cube/app/features/cube_timer/enum/timer_states.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/timer/bloc/cube_timer_bloc.dart';
import 'package:flutter/material.dart';

class PressButtons extends StatelessWidget {
  final CubeTimerBloc cubeTimerBloc;
  final bool isPressed;
  final TimerState timerState;

  const PressButtons(
      {super.key,
      required this.cubeTimerBloc,
      required this.isPressed,
      required this.timerState});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double widthMinusFactor = 0.25;
    const double iconMinusFactor = 0.15;
    const double pressedIconMinusFactor = 0.13;
    const double boxRadius = 100;
    const double strokeWidth = 5;
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
      child: GestureDetector(
        onLongPressStart: (details) {
          cubeTimerBloc.prepareToGo();
          cubeTimerBloc.setPressed(true);
        },
        onLongPressEnd: (details) {
          cubeTimerBloc.verifyPressedTimeCanGo();
          cubeTimerBloc.setPressed(false);
        },
        onTap: () {
          if (timerState == TimerState.running) {
            cubeTimerBloc.stopTimer();
            return;
          }

          cubeTimerBloc.startTimer();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: screenWidth * widthMinusFactor,
              width: screenWidth * widthMinusFactor,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: strokeWidth),
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(boxRadius))),
              child: Icon(
                Icons.back_hand_outlined,
                size: isPressed
                    ? screenWidth * pressedIconMinusFactor
                    : screenWidth * iconMinusFactor,
                color: Colors.black,
              ),
            ),
            Container(
              height: screenWidth * widthMinusFactor,
              width: screenWidth * widthMinusFactor,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: strokeWidth),
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(boxRadius))),
              child: Icon(
                Icons.back_hand_outlined,
                size: isPressed
                    ? screenWidth * pressedIconMinusFactor
                    : screenWidth * iconMinusFactor,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
