import 'package:crono_cube/app/features/cube_timer/models/solve.dart';

abstract class SolveListState {}

class InitialSolveListState extends SolveListState {}

class LoadingSolveListState extends SolveListState {}

class LoadedSolveListState extends SolveListState {
  List<Solve> solves;

  double ao5;
  double ao12;

  LoadedSolveListState(
      {required this.solves, required this.ao12, required this.ao5});
}

class ErrorSolveListState extends SolveListState {
  String error;

  ErrorSolveListState({required this.error});
}
