import 'package:crono_cube/app/features/home/home_view.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"/": (context) => const HomeView()},
      initialRoute: "/",
    );
  }
}
