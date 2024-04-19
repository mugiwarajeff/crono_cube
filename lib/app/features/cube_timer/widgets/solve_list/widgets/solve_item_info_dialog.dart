import 'package:crono_cube/app/features/configurations/utils/utils.dart';
import 'package:crono_cube/app/features/cube_timer/models/solve.dart';
import 'package:crono_cube/app/features/cube_timer/utils/timer_utils.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/bloc/solve_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SolveItemInfoDialog extends StatefulWidget {
  final int index;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final Solve tempSolve;
  SolveItemInfoDialog({super.key, required Solve solve, required this.index})
      : tempSolve = solve.clone();

  @override
  State<SolveItemInfoDialog> createState() => _SolveItemInfoDialogState();
}

class _SolveItemInfoDialogState extends State<SolveItemInfoDialog> {
  @override
  Widget build(BuildContext context) {
    SolveListCubit solveListCubit = BlocProvider.of<SolveListCubit>(context);
    final Size screenSize = MediaQuery.of(context).size;
    const String title = "Solve";
    const double titleSize = 24;
    const double timeSize = 32;
    const int lineQuant = 6;
    const String commentsLabel = "Comentários";
    const String commentsHint = "Adicione seus comentarios da Solve...";
    return Dialog(
      child: SizedBox(
        height: screenSize.height * 0.6,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$title: ${widget.index}",
                  style: const TextStyle(fontSize: titleSize),
                ),
                Text(
                  widget.tempSolve.scramble,
                  style: const TextStyle(fontSize: titleSize),
                ),
                Form(
                    key: widget.formState,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                                "${formatMilisegunds(widget.tempSolve.time)} :",
                                style: const TextStyle(fontSize: timeSize)),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(106, 244, 67, 54),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: Text(
                                      ConfigurationsUtils.translateCubeType(
                                          widget.tempSolve.cubeType))),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(106, 244, 67, 54),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: Text(
                                      ConfigurationsUtils.translateCubeTag(
                                          widget.tempSolve.cubeTag))),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: widget.tempSolve.comment,
                          onChanged: (value) =>
                              widget.tempSolve.comment = value,
                          maxLines: lineQuant,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(commentsLabel),
                              hintText: commentsHint),
                        )
                      ],
                    )),
                ButtonBar(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await solveListCubit.updateSolve(widget.tempSolve);
                          Navigator.of(context).pop();
                        },
                        child: const Text("Confirmar")),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Cancelar")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
