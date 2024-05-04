import 'package:flutter/material.dart';

class ScrumbleDetails extends StatelessWidget {
  final String scrumble;
  const ScrumbleDetails({super.key, required this.scrumble});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    const double fontSize = 18;
    return Dialog(
      child: SizedBox(
          height: screenSize.height * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  scrumble,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: fontSize),
                )
              ],
            ),
          )),
    );
  }
}
