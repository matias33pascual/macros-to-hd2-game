class MissionState {
  MissionState._();

  static final MissionState _instance = MissionState._();

  static MissionState get instance => _instance;

  double buttonsForRow = 4;
  double maxButtonsForRowInPortrait = 7;
  double maxButtonsForRowInLandscape = 11;
  double minButtonsForRow = 2;

  final String gridIconPath = "assets/images/count.png";
}
