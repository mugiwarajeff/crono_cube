import 'package:crono_cube/app/features/configurations/bloc/configuations_state.dart';
import 'package:crono_cube/app/features/configurations/bloc/configurations_bloc.dart';
import 'package:crono_cube/app/features/configurations/models/configurations.dart';
import 'package:crono_cube/app/features/configurations/models/value_object/time_inspect.dart';
import 'package:crono_cube/app/features/configurations/utils/utils.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_tag.dart';
import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ConfigurationsDialog extends StatefulWidget {
  final ConfigurationsBloc configurationsBloc;
  final TextEditingController timeInspectController;
  final Configurations configurations;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  ConfigurationsDialog({super.key, required this.configurationsBloc})
      : configurations = configurationsBloc.configurations.clone(),
        timeInspectController = TextEditingController(
            text:
                configurationsBloc.configurations.timeInspect.value.toString());

  @override
  State<ConfigurationsDialog> createState() => _ConfigurationsDialogState();
}

class _ConfigurationsDialogState extends State<ConfigurationsDialog> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    const String dialogText = "Configurações";
    const double dialogTitleSize = 24;

    const String cubeTypelabel = "Tipo de Cubo";
    const String cubeTagLabel = "Tag do Cubo";
    const String inspectTimeLabel = "Tempo de Inspeção";

    final Color erroColor = Theme.of(context).colorScheme.error;
    final Color onErrorColor = Theme.of(context).colorScheme.onError;

    final Color successColor = Theme.of(context).colorScheme.secondary;
    final Color onSuccessColor = Theme.of(context).colorScheme.onSecondary;
    return Dialog(
      child: SizedBox(
        height: widget.configurations.inspect
            ? screenSize.height * 0.72
            : screenSize.height * 0.64,
        child: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 16, right: 16),
            child: BlocConsumer<ConfigurationsBloc, ConfigurationsState>(
              listener: (context, state) {
                if (state is SuccessOnUpdateState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      state.message,
                      style: TextStyle(color: onSuccessColor),
                    ),
                    backgroundColor: successColor,
                  ));

                  Navigator.of(context).pop();
                }

                if (state is ErrorConfigurationsState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      state.error,
                      style: TextStyle(color: onErrorColor),
                    ),
                    backgroundColor: erroColor,
                  ));
                }
              },
              bloc: widget.configurationsBloc,
              builder: (context, state) {
                if (state is LoadingConfigurationsState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LoadedConfigurationsState) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          dialogText,
                          style: TextStyle(fontSize: dialogTitleSize),
                        ),
                        Form(
                            key: widget.formkey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                DropdownButtonFormField<CubeType>(
                                    decoration: const InputDecoration(
                                        label: Text(cubeTypelabel)),
                                    value: widget.configurations.cubeType,
                                    items: CubeType.values
                                        .map((cubeType) => DropdownMenuItem(
                                              value: cubeType,
                                              child: Text(ConfigurationsUtils
                                                  .translateCubeType(cubeType)),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      widget.configurations.cubeType = value!;
                                      setState(() {});
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                DropdownButtonFormField<CubeTag>(
                                    decoration: const InputDecoration(
                                        label: Text(cubeTagLabel)),
                                    value: widget.configurations.cubeTag,
                                    items: CubeTag.values
                                        .map((cubeTag) => DropdownMenuItem(
                                            value: cubeTag,
                                            child: Text(ConfigurationsUtils
                                                .translateCubeTag(cubeTag))))
                                        .toList(),
                                    onChanged: (value) {
                                      widget.configurations.cubeTag = value!;
                                      setState(() {});
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  title: const Text("Tema Escuro"),
                                  trailing: Switch(
                                    value: widget.configurations.darkTheme,
                                    onChanged: (value) {
                                      widget.configurations.darkTheme = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  title: const Text("Inspecionar"),
                                  trailing: Switch(
                                    value: widget.configurations.inspect,
                                    onChanged: (value) {
                                      widget.configurations.inspect = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: widget.configurations.inspect,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      widget.timeInspectController.text = value;
                                      widget.configurations.timeInspect =
                                          TimeInspect(
                                              value: int.tryParse(value) ?? 0);
                                    },
                                    controller: widget.timeInspectController,
                                    validator: widget
                                        .configurations.timeInspect.validate,
                                    decoration: InputDecoration(
                                        suffixIcon: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                String newNumber = (widget
                                                            .configurations
                                                            .timeInspect
                                                            .value +
                                                        1)
                                                    .toString();
                                                widget.timeInspectController
                                                    .text = newNumber;
                                                widget.configurations
                                                        .timeInspect =
                                                    TimeInspect(
                                                        value: int.tryParse(
                                                                newNumber) ??
                                                            0);

                                                setState(() {});
                                              },
                                              child: const Icon(
                                                  Icons.arrow_upward),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  String newNumber = (widget
                                                              .configurations
                                                              .timeInspect
                                                              .value -
                                                          1)
                                                      .toString();
                                                  widget.timeInspectController
                                                      .text = newNumber;
                                                  widget.configurations
                                                          .timeInspect =
                                                      TimeInspect(
                                                          value: int.tryParse(
                                                                  newNumber) ??
                                                              0);
                                                },
                                                child: const Icon(
                                                    Icons.arrow_downward))
                                          ],
                                        ),
                                        label: const Text(inspectTimeLabel)),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  title: const Text("Pressionar Largada"),
                                  trailing: Switch(
                                    value: widget.configurations.pressToRun,
                                    onChanged: (value) {
                                      widget.configurations.pressToRun = value;

                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            )),
                        ButtonBar(
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  if (widget.formkey.currentState?.validate() ??
                                      false) {
                                    await widget.configurationsBloc
                                        .updateConfigurations(
                                            widget.configurations);
                                  }
                                },
                                child: const Text("Confirmar")),
                            ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("Cancelar")),
                          ],
                        )
                      ],
                    ),
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
