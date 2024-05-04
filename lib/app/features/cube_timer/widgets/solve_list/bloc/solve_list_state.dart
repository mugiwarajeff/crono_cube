import 'package:crono_cube/app/features/cube_timer/models/solve.dart';

abstract class SolveListState {}

class InitialSolveListState extends SolveListState {}

class LoadingSolveListState extends SolveListState {}

class LoadedSolveListState extends SolveListState {
  List<Solve> solves;

  LoadedSolveListState({required this.solves});
}

class ErrorSolveListState extends SolveListState {
  String error;

  ErrorSolveListState({required this.error});
}
