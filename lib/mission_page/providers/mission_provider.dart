import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/mission_page/states/mission_state.dart';

class MissionProvider extends ChangeNotifier {
  MissionState state = MissionState.instance;

  String getIconPath() {
    final String iconPath = state.gridIconPath;

    return iconPath;
  }

  void setNewLayout() {
    double nextButtonDistribution = ++state.buttonsForRow % 11;
    state.buttonsForRow = nextButtonDistribution < 2 ? 2 : nextButtonDistribution;
    notifyListeners();
  }

  updateButtonsDistributionCount() {}
}
