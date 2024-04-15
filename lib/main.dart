import 'package:crono_cube/app/app.dart';
import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    lazy: false,
    create: (context) => ConfigurationsBloc(),
    child: const App(),
  ));
}
