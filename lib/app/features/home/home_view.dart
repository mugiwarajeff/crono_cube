import 'package:crono_cube/app/features/configurations/configurations_dialog.dart';
import 'package:crono_cube/app/features/cube_timer/cube_timer.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const String homeTitle = "Crono Cube";

    void showConfigurationsDialog() {
      showDialog(
        context: context,
        builder: (context) => const ConfigurationsDialog(),
      );
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
