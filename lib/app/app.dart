import 'package:crono_cube/app/features/configurations/bloc/configuations_state.dart';
import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:crono_cube/app/features/home/home_view.dart';
import 'package:crono_cube/app/shared/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationsBloc, ConfigurationsState>(
      builder: (context, state) {
        if (state is LoadedConfigurationsState) {
          return MaterialApp(
            theme: state.configurations.darkTheme ? darkTheme : lightTheme,
            routes: {
              "/": (context) => const HomeView(),
            },
            initialRoute: "/",
          );
        } else {
          return Container();
        }
      },
    );
  }
}
