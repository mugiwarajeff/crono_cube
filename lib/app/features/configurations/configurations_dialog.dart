import 'package:crono_cube/app/features/configurations/bloc/configuations_state.dart';
import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfigurationsDialog extends StatelessWidget {
  const ConfigurationsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double dialogSize = screenSize.height * 0.7;
    const String dialogText = "Configurações";
    const double dialogTitleSize = 24;
    return Dialog(
      child: SizedBox(
        height: dialogSize,
        child: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 16, right: 16),
            child: BlocBuilder<ConfigurationsBloc, ConfigurationsState>(
              builder: (context, state) {
                if (state is LoadingConfigurationsState) {
                  return const SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator());
                } else if (state is LoadedConfigurationsState) {
                  return Column(
                    children: [
                      const Text(
                        dialogText,
                        style: TextStyle(fontSize: dialogTitleSize),
                      ),
                      Switch(
                        value: true,
                        onChanged: (value) {},
                      )
                    ],
                  );
                } else if (state is ErrorConfigurationsState) {
                  return const Text("Falha ao Obter Configurações");
                } else {
                  return Container();
                }
              },
            )),
      ),
    );
  }
}
