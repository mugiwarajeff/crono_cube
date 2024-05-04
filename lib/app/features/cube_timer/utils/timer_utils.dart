import 'package:crono_cube/app/features/cube_timer/enum/timer_states.dart';
import 'package:flutter/material.dart';

String formatCronometerText(int milliseconds) {
  return "${(milliseconds / 1000) < 10 ? "0" : ""}${(milliseconds / 1000).toStringAsFixed(2)}";
}

Color selectTextColor(TimerState timerState, BuildContext context) {
  Color color = Theme.of(context).colorScheme.onBackground;
  switch (timerState) {
    case TimerState.initial:
      return color;

    case TimerState.preparing:
      return Colors.red;
    case TimerState.ready:
      return Colors.green;
    case TimerState.running:
      return color;
    case TimerState.inspecting:
      return color;
    case TimerState.plusTwo:
      return color;
    case TimerState.dnf:
      return color;
  }
}

String formatMilisegunds(int miliseconds) {
  double seconds = (miliseconds / 1000);
  return "${seconds < 10 ? "0" : ""}${seconds.toStringAsFixed(2)}";
}
