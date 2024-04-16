import 'package:crono_cube/app/features/cube_timer/models/solve.dart';
import 'package:flutter/material.dart';

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

    String formatMilisegunds(int miliseconds) {
      double seconds = (miliseconds / 1000);
      return "${seconds < 10 ? "0" : ""}${seconds.toStringAsFixed(2)}";
    }

    String limitScramle(String scramble) {
      if (scramble.length >= 55) {
        return "${scramble.substring(0, 55)}...";
      }

      return scramble;
    }

    return Card(
      child: ListTile(
        leading: Text(
          index.toString(),
          style: const TextStyle(fontSize: indexSize),
        ),
        title: Text(
          formatMilisegunds(solve.time),
          style: const TextStyle(fontSize: timeSize),
        ),
        subtitle: Text(
          limitScramle(solve.scramble),
          style: const TextStyle(fontSize: scrumbleSize),
        ),
        trailing: IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ),
    );
  }
}
