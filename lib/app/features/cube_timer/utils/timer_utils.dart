import 'package:crono_cube/app/features/cube_timer/enum/timer_states.dart';
import 'package:flutter/material.dart';

String formatCronometerText(int milliseconds) {
  return "${(milliseconds / 1000) < 10 ? "0" : ""}${(milliseconds / 1000).toStringAsFixed(2)}";
}

Color selectTextColor(TimerState timerState) {
  switch (timerState) {
    case TimerState.initial:
      return Colors.black;

    case TimerState.preparing:
      return Colors.red;
    case TimerState.ready:
      return Colors.green;
    case TimerState.running:
      return Colors.black;
  }
}
