import 'package:crono_cube/app/features/cube_timer/models/solve.dart';
import 'package:crono_cube/app/features/cube_timer/utils/timer_utils.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_cubit.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/widgets/solve_item_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SolveItem extends StatelessWidget {
  final int index;
  final Solve solve;

  final Function() onDelete;
  const SolveItem(
      {super.key,
      required this.solve,
      required this.index,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    const double indexSize = 16;
    const double timeSize = 16;
    const double scrumbleSize = 10;

    final Color secondaryColor = Theme.of(context).colorScheme.secondary;
    final Color errorColor = Theme.of(context).colorScheme.error;

    SolveListCubit solveListCubit = BlocProvider.of<SolveListCubit>(context);

    String limitScramle(String scramble) {
      if (scramble.length >= 55) {
        return "${scramble.substring(0, 55)}...";
      }

      return scramble;
    }

    void showSolveInfo() {
      showDialog(
        context: context,
        builder: (context) => SolveItemInfoDialog(
          solve: solve,
          index: index,
        ),
      );
    }

    return InkWell(
      onTap: showSolveInfo,
      child: Card(
        child: ListTile(
          leading: Text(
            index.toString(),
            style: const TextStyle(fontSize: indexSize),
          ),
          title: Text(
            solve.dnf ? "DNF" : formatMilisegunds(solve.time),
            style: const TextStyle(fontSize: timeSize),
          ),
          subtitle: Text(
            limitScramle(solve.scramble),
            style: const TextStyle(fontSize: scrumbleSize),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    solve.dnf = !solve.dnf;
                    solveListCubit.updateSolve(solve);
                  },
                  icon: Text(
                    "DNF",
                    style: TextStyle(
                        color: solve.dnf ? secondaryColor : Colors.grey),
                  )),
              IconButton(
                  onPressed: () {
                    solve.plusTwo = !solve.plusTwo;
                    solveListCubit.updateSolve(solve);
                  },
                  icon: Text(
                    "+2",
                    style: TextStyle(
                        color: solve.plusTwo ? secondaryColor : Colors.grey),
                  )),
              IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete, color: errorColor)),
            ],
          ),
        ),
      ),
    );
  }
}
