import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/models/solve.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_state.dart';
import 'package:crono_cube/database/daos/solve_dao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SolveListCubit extends Cubit<SolveListState> {
  final SolveDao _solveDao = SolveDao();
  final List<Solve> _solves = [];
  double _ao5 = 0;
  double _ao12 = 0;

  SolveListCubit() : super(InitialSolveListState());

  Future<void> loadSolves(CubeType cubeType, CubeTag cubeTag) async {
    emit(LoadingSolveListState());
    List<Solve> solvesFromDb =
        await _solveDao.getSolvesByCubeType(cubeType, cubeTag);

    _solves.clear();
    _solves.addAll(solvesFromDb);
    _loadStats();
    emit(LoadedSolveListState(solves: _solves, ao12: _ao12, ao5: _ao5));
  }

  void _loadStats() {
    _ao12 = getAo12();
    _ao5 = getAo5();
  }

  double getAo5() {
    double ao5 = 0;
    if (_solves.length < 5) {
      return ao5;
    }

    var md5List = _solves.getRange(_solves.length - 5, _solves.length - 1);

    for (Solve solve in md5List) {
      if (solve.dnf) {
        ao5 = -1;
        return ao5;
      }

      ao5 += solve.time;
    }

    ao5 = ao5 / md5List.length;

    return ao5;
  }

  double getAo12() {
    double ao12 = 0;
    if (_solves.length < 12) {
      return ao12;
    }

    var md5List = _solves.getRange(_solves.length - 12, _solves.length - 1);

    for (Solve solve in md5List) {
      if (solve.dnf) {
        ao12 = -1;
        return ao12;
      }

      ao12 += solve.time;
    }

    ao12 = ao12 / md5List.length;

    return ao12;
  }

  Future<void> addNewSolve(Solve solve) async {
    emit(LoadingSolveListState());

    int newId = await _solveDao.insertSolve(solve);

    if (newId != 0) {
      solve.id = newId;
      _solves.add(solve);
      _loadStats();
      emit(LoadedSolveListState(solves: _solves, ao12: _ao12, ao5: _ao5));
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

      _loadStats();
      emit(LoadedSolveListState(solves: _solves, ao12: _ao12, ao5: _ao5));
    } else {
      emit(ErrorSolveListState(error: "Unknown"));
    }
  }

  Future<void> removeSolve(Solve solve) async {
    int removedLines = await _solveDao.deleteSolve(solve);

    if (removedLines > 0) {
      _solves.remove(solve);
      _loadStats();
      emit(LoadedSolveListState(solves: _solves, ao12: _ao12, ao5: _ao5));
    } else {
      emit(ErrorSolveListState(error: "Unknown"));
    }
  }
}
