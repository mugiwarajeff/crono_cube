import 'package:crono_cube/app/features/configurations/bloc/configuations_state.dart';
import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/scrumble/scrumble_viewer.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/solve_list/solve_list.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/timer/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubeTimer extends StatelessWidget {
  const CubeTimer({super.key});

  @override
  Widget build(BuildContext context) {
    const double dividerSize = 2;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<ConfigurationsBloc, ConfigurationsState>(
            builder: (context, state) {
              if (state is LoadedConfigurationsState) {
                return ScrumbleViewer(cubeType: state.configurations.cubeType);
              } else {
                return Container();
              }
            },
          ),
          BlocBuilder<ConfigurationsBloc, ConfigurationsState>(
            builder: (context, state) {
              if (state is LoadedConfigurationsState) {
                return Timer(
                  cubeTag: state.configurations.cubeTag,
                  cubeType: state.configurations.cubeType,
                );
              } else {
                return Container();
              }
            },
          ),
          const Divider(
            thickness: dividerSize,
            color: Colors.blue,
          ),
          BlocBuilder<ConfigurationsBloc, ConfigurationsState>(
            builder: (context, state) {
              if (state is LoadedConfigurationsState) {
                return SolveList(
                  cubeType: state.configurations.cubeType,
                  cubeTag: state.configurations.cubeTag,
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
