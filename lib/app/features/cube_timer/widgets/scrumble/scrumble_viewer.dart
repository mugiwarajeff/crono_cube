import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/scrumble/bloc/scrumble_cubit.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/scrumble/bloc/scrumble_state.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/scrumble/scrumble_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrumbleViewer extends StatelessWidget {
  final CubeType cubeType;
  const ScrumbleViewer({super.key, required this.cubeType});

  @override
  Widget build(BuildContext context) {
    final ScrumbleCubit scrumbleCubit = BlocProvider.of<ScrumbleCubit>(context);

    scrumbleCubit.loadScrumble(cubeType);
    const int scrumbleCutLenghtCondition = 60;
    const double scrumbleTextSize = 18;

    return BlocConsumer<ScrumbleCubit, ScrumbleState>(
      bloc: scrumbleCubit,
      listener: (context, state) {
        if (state is ResetScrumbleState) {
          scrumbleCubit.loadScrumble(cubeType);
        }
      },
      builder: (context, state) {
        if (state is LoadingScrumbleState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedScrumbleState) {
          return InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) =>
                      ScrumbleDetails(scrumble: state.scrumble));
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.scrumble.length > scrumbleCutLenghtCondition
                      ? "${state.scrumble.substring(0, scrumbleCutLenghtCondition)}..."
                      : state.scrumble,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: scrumbleTextSize),
                ),
              ),
            ),
          );
        } else if (state is Error) {
          return const Text("Erro ao gerar Scrumble");
        } else {
          return Container();
        }
      },
    );
  }
}
