abstract class ScrumbleState {}

class InitialScrumbleState extends ScrumbleState {}

class LoadingScrumbleState extends ScrumbleState {}

class LoadedScrumbleState extends ScrumbleState {
  final String scrumble;

  LoadedScrumbleState({required this.scrumble});
}

class ResetScrumbleState extends ScrumbleState {}

class ErrorScrumbleState extends ScrumbleState {
  final String error;

  ErrorScrumbleState({required this.error});
}
