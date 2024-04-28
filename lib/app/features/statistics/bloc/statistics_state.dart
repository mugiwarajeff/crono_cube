abstract class StatisticsState {}

class InitialStatisticsState extends StatisticsState {}

class LoadingStatisticsState extends StatisticsState {}

class LoadedStatisticsState extends StatisticsState {
  double ao5;
  double ao12;

  LoadedStatisticsState({required this.ao12, required this.ao5});
}

class ErrorStatisticsState extends StatisticsState {
  String error;

  ErrorStatisticsState({required this.error});
}
