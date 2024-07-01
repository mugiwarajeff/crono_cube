import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:crono_cube/app/features/configurations/configurations_dialog.dart';
import 'package:crono_cube/app/features/cube_timer/cube_timer.dart';
import 'package:crono_cube/app/features/statistics/statistics_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _index = 0;

  Widget _selectPage() {
    switch (_index) {
      case 0:
        return const CubeTimer();
      case 1:
        return const StatisticsPage();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color secondaryColor = Theme.of(context).colorScheme.onSecondary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.surface;
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
      body: _selectPage(),
      bottomNavigationBar: CurvedNavigationBar(
          items: [
            Icon(
              Icons.timer,
              color: _index == 0 ? primaryColor : secondaryColor,
            ),
            Icon(
              Icons.bar_chart_rounded,
              color: _index == 1 ? primaryColor : secondaryColor,
            ),
          ],
          height: 60,
          backgroundColor: onPrimaryColor,
          color: primaryColor,
          buttonBackgroundColor: onPrimaryColor,
          index: _index,
          onTap: (newIndex) {
            _index = newIndex;
            setState(() {});
          }),
    );
  }
}
