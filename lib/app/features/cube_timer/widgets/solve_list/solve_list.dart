import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/models/solve.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_cubit.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_state.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/widgets/solve_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SolveList extends StatelessWidget {
  final CubeType cubeType;
  final CubeTag cubeTag;
  const SolveList({super.key, required this.cubeType, required this.cubeTag});

  @override
  Widget build(BuildContext context) {
    SolveListCubit solveListCubit = BlocProvider.of<SolveListCubit>(context);
    solveListCubit.loadSolves(cubeType, cubeTag);

    return Expanded(
      flex: 1,
      child: SizedBox(
        width: double.infinity,
        child: BlocBuilder<SolveListCubit, SolveListState>(
          bloc: solveListCubit,
          builder: (context, state) {
            if (state is LoadingSolveListState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedSolveListState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  Solve solve = state.solves.reversed.elementAt(index);
                  return SolveItem(
                    solve: solve,
                    index: state.solves.indexOf(solve) + 1,
                    onDelete: () {
                      solveListCubit.removeSolve(solve);
                    },
                  );
                },
                itemCount: state.solves.length,
              );
            } else if (state is ErrorSolveListState) {
              return Text(state.error);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
