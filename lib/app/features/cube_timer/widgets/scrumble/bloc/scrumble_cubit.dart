import 'package:crono_cube/app/features/cube_timer/enum/cube_type.dart';
import 'package:crono_cube/app/features/cube_timer/services/interfaces/scrumble_generator.dart';
import 'package:crono_cube/app/features/cube_timer/widgets/scrumble/bloc/scrumble_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrumbleCubit extends Cubit<ScrumbleState> {
  String? _scrumble;
  final ScrumbleGenerator scrumbleGenerator;

  String get scrumble => _scrumble ?? "";

  ScrumbleCubit({required this.scrumbleGenerator})
      : super(InitialScrumbleState());

  Future<void> loadScrumble(CubeType cubeType) async {
    emit(LoadingScrumbleState());
    _scrumble = scrumbleGenerator.selectScrumbeForCubeType(cubeType);

    emit(LoadedScrumbleState(scrumble: _scrumble ?? ""));
  }

  void resetScramble() async {
    emit(ResetScrumbleState());
  }
}
