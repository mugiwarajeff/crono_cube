import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:crono_cube/app/features/configurations/configurations_dialog.dart';
import 'package:crono_cube/app/features/cube_timer/cube_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const String homeTitle = "Crono Cube";

    void showConfigurationsDialog() {
      showDialog(
          context: context,
          builder: (context) {
            ConfigurationsBloc configurationsBloc =
                BlocProvider.of<ConfigurationsBloc>(context);

            return ConfigurationsDialog(
              configurationsBloc: configurationsBloc,
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(homeTitle),
        actions: [
          IconButton(
              onPressed: () => showConfigurationsDialog(),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: const CubeTimer(),
    );
  }
}
