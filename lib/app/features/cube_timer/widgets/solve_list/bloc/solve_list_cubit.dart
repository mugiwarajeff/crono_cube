import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/models/solve.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_state.dart';
import 'package:crono_cube/database/daos/solve_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SolveListCubit extends Cubit<SolveListState> {
  final SolveDao _solveDao = SolveDao();
  final List<Solve> _solves = [];

  SolveListCubit() : super(InitialSolveListState());

  Future<void> loadSolves(CubeType cubeType, CubeTag cubeTag) async {
    emit(LoadingSolveListState());
    List<Solve> solvesFromDb =
        await _solveDao.getSolvesByCubeType(cubeType, cubeTag);

    _solves.clear();
    _solves.addAll(solvesFromDb);

    emit(LoadedSolveListState(solves: _solves));
  }

  Future<void> addNewSolve(Solve solve) async {
    emit(LoadingSolveListState());

    int newId = await _solveDao.insertSolve(solve);

    if (newId != 0) {
      solve.id = newId;
      _solves.add(solve);
      emit(LoadedSolveListState(solves: _solves));
    } else {
      emit(ErrorSolveListState(error: "Unknown"));
    }
  }

  Future<void> updateSolve(Solve solve) async {
    int updatedLines = await _solveDao.updateSolve(solve);

    if (updatedLines > 0) {
      Solve getSolve = _solves.where((element) => element.id == solve.id).first;

      int index = _solves.indexOf(getSolve);
      _solves.remove(getSolve);
      _solves.insert(index, solve);

      emit(LoadedSolveListState(solves: _solves));
    } else {
      emit(ErrorSolveListState(error: "Unknown"));
    }
  }

  Future<void> removeSolve(Solve solve) async {
    int removedLines = await _solveDao.deleteSolve(solve);

    if (removedLines > 0) {
      _solves.remove(solve);
      emit(LoadedSolveListState(solves: _solves));
    } else {
      emit(ErrorSolveListState(error: "Unknown"));
    }
  }
}
