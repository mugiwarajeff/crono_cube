import 'package:crono_cube/app/features/cube_timer/cube_timer.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const String homeTitle = "Crono Cube";
    return Scaffold(
      appBar: AppBar(
        title: const Text(homeTitle),
      ),
      body: const CubeTimer(),
    );
  }
}
