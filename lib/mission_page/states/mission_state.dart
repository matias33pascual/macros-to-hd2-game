class MissionState {
  MissionState._();

  static final MissionState _instance = MissionState._();

  static MissionState get instance => _instance;

  double buttonsForRow = 4;

  final String gridIconPath = "assets/images/count.png";
}
