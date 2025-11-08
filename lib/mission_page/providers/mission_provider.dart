import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/mission_page/states/mission_state.dart';

class MissionProvider extends ChangeNotifier {
  MissionState state = MissionState.instance;

  String getIconPath() {
    final String iconPath = state.gridIconPath;
    return iconPath;
  }

  void setNewLayout(BuildContext context) {
    double maxButtons = MediaQuery.of(context).orientation == Orientation.portrait
        ? state.maxButtonsForRowInPortrait
        : state.maxButtonsForRowInLandscape;

    double nextButtonDistribution = ++state.buttonsForRow % maxButtons;
    state.buttonsForRow =
        nextButtonDistribution < state.minButtonsForRow ? state.minButtonsForRow : nextButtonDistribution;
    notifyListeners();
  }

  int getButtonsForRow(BuildContext context) {
    double maxButtons = MediaQuery.of(context).orientation == Orientation.portrait
        ? state.maxButtonsForRowInPortrait
        : state.maxButtonsForRowInLandscape;

    return state.buttonsForRow > maxButtons ? maxButtons.toInt() - 1 : state.buttonsForRow.toInt();
  }
}
