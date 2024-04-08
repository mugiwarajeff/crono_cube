import 'package:crono_cube/app/features/cube_timer/widgets/timer/timer.dart';
import 'package:flutter/material.dart';

class CubeTimer extends StatelessWidget {
  const CubeTimer({super.key});

  @override
  Widget build(BuildContext context) {
    const double dividerSize = 2;
    return const SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Timer(),
          Divider(
            thickness: dividerSize,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
