import 'package:crono_cube/app/features/configurations/bloc/configuations_state.dart';
import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:crono_cube/app/features/configurations/utils/utils.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ConfigurationsDialog extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  ConfigurationsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ConfigurationsBloc configurationsBloc =
        BlocProvider.of<ConfigurationsBloc>(context);

    configurationsBloc.initTempConfigurations();

    final Size screenSize = MediaQuery.of(context).size;
    final double dialogSize = screenSize.height * 0.75;
    const String dialogText = "Configurações";
    const double dialogTitleSize = 24;

    const String cubeTypelabel = "Tipo de Cubo";
    const String cubeTagLabel = "Tag do Cubo";
    const String inspectTimeLabel = "Tempo de Inspeção";
    return Dialog(
      child: SizedBox(
        height: dialogSize,
        child: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 16, right: 16),
            child: BlocBuilder<ConfigurationsBloc, ConfigurationsState>(
              bloc: configurationsBloc,
              builder: (context, state) {
                if (state is LoadingConfigurationsState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LoadedConfigurationsState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        dialogText,
                        style: TextStyle(fontSize: dialogTitleSize),
                      ),
                      Form(
                          key: formkey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              DropdownButtonFormField<CubeType>(
                                  decoration: const InputDecoration(
                                      label: Text(cubeTypelabel)),
                                  value: state.tempConfigurations.cubeType,
                                  items: CubeType.values
                                      .map((cubeType) => DropdownMenuItem(
                                            value: cubeType,
                                            child: Text(ConfigurationsUtils
                                                .translateCubeType(cubeType)),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    configurationsBloc.setCubeType(value!);
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              DropdownButtonFormField<CubeTag>(
                                  decoration: const InputDecoration(
                                      label: Text(cubeTagLabel)),
                                  value: state.tempConfigurations.cubeTag,
                                  items: CubeTag.values
                                      .map((cubeTag) => DropdownMenuItem(
                                          value: cubeTag,
                                          child: Text(ConfigurationsUtils
                                              .translateCubeTag(cubeTag))))
                                      .toList(),
                                  onChanged: (value) {
                                    configurationsBloc.setCubeTag(value!);
                                  }),
                              const SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                title: const Text("Tema Escuro"),
                                trailing: Switch(
                                  value: state.tempConfigurations.darkTheme,
                                  onChanged: (value) {
                                    configurationsBloc.setTempDarkMode(value);
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                title: const Text("Inspecionar"),
                                trailing: Switch(
                                  value: state.tempConfigurations.inspect,
                                  onChanged: (value) {
                                    configurationsBloc.setTempInspect(value);
                                  },
                                ),
                              ),
                              Visibility(
                                visible: state.tempConfigurations.inspect,
                                child: TextFormField(
                                  initialValue: state
                                      .tempConfigurations.timeInspect
                                      .toString(),
                                  decoration: const InputDecoration(
                                      label: Text(inspectTimeLabel)),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                title: const Text("Pressionar Largada"),
                                trailing: Switch(
                                  value: state.tempConfigurations.pressToRun,
                                  onChanged: (value) {
                                    configurationsBloc.setTempPressToRun(value);
                                  },
                                ),
                              ),
                            ],
                          )),
                      ButtonBar(
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                if (formkey.currentState?.validate() ?? false) {
                                  bool updated = await configurationsBloc
                                      .updateConfigurations(
                                          state.tempConfigurations);

                                  if (updated) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Configurações Atualizadas"),
                                      backgroundColor: Colors.green,
                                    ));
                                  }

                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text("Confirmar")),
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Cancelar")),
                        ],
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
