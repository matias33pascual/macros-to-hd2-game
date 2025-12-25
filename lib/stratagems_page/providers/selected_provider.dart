import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/stratagems_page/state/stratagems_state.dart';

class SelectedProvider extends ChangeNotifier {
  StratagemsState state = StratagemsState.instance;

  void update() {
    notifyListeners();
  }
}
