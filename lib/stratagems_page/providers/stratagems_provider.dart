import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:macros_to_helldivers/stratagems_page/models/stratagems_model.dart';
import 'package:macros_to_helldivers/stratagems_page/models/tabs_menu_enum.dart';
import 'package:macros_to_helldivers/stratagems_page/providers/exports_providers.dart';
import 'package:macros_to_helldivers/stratagems_page/services/stratagems_service.dart';
import 'package:macros_to_helldivers/stratagems_page/state/stratagems_state.dart';
import 'package:provider/provider.dart';

class StratagemsProvider extends ChangeNotifier {
  StratagemsService service = StratagemsService.instance;
  StratagemsState state = StratagemsState.instance;

  Future loadStratagems() async {
    if (state.stratagems.isNotEmpty) {
      return;
    }

    try {
      state.stratagems = await service.loadStratagemsFromFile("stratagems");

      _divideStratagemsTypesList();

      state.tabMenuSelected = TabsMenuEnum.mission;

      state.listToShow = state.missionStratagemsList;
    } catch (error) {
      if (kDebugMode) {
        print("Error al cargar las estratagemas en loadStratagems: $error");
      }
      rethrow;
    }
  }

  void _divideStratagemsTypesList() {
    for (var stratagem in state.stratagems) {
      switch (stratagem.type) {
        case StratagemTypesEnum.mission:
          state.missionStratagemsList.add(stratagem);
          break;

        case StratagemTypesEnum.eagle:
          state.eagleStratagemsList.add(stratagem);
          break;

        case StratagemTypesEnum.orbital:
          state.orbitalStratagemsList.add(stratagem);
          break;

        case StratagemTypesEnum.defenses:
          state.defensesStratagemsList.add(stratagem);
          break;

        case StratagemTypesEnum.weapons:
          state.weaponsStratagemsList.add(stratagem);
          break;

        case StratagemTypesEnum.backpacks:
          state.backpacksStratagemsList.add(stratagem);
      }
    }
  }

  void onHorizontalGestureHandler(DragEndDetails details, BuildContext context) {
    if (details.velocity.pixelsPerSecond.dx > 0) {
      _moveToPreviousTabMenu(context);
    } else if (details.velocity.pixelsPerSecond.dx < 0) {
      _moveToNextTabMenu(context);
    }
  }

  void _moveToNextTabMenu(BuildContext context) {
    switch (state.tabMenuSelected) {
      case TabsMenuEnum.mission:
        onTabMenuHandler(TabsMenuEnum.eagle, context);
        break;
      case TabsMenuEnum.eagle:
        onTabMenuHandler(TabsMenuEnum.orbital, context);
        break;
      case TabsMenuEnum.orbital:
        onTabMenuHandler(TabsMenuEnum.weapons, context);
        break;
      case TabsMenuEnum.weapons:
        onTabMenuHandler(TabsMenuEnum.backpacks, context);
        break;
      case TabsMenuEnum.backpacks:
        onTabMenuHandler(TabsMenuEnum.defenses, context);
        break;
      case TabsMenuEnum.defenses:
        onTabMenuHandler(TabsMenuEnum.mission, context);
        break;
    }
  }

  void _moveToPreviousTabMenu(BuildContext context) {
    switch (state.tabMenuSelected) {
      case TabsMenuEnum.mission:
        onTabMenuHandler(TabsMenuEnum.defenses, context);
        break;
      case TabsMenuEnum.eagle:
        onTabMenuHandler(TabsMenuEnum.mission, context);
        break;
      case TabsMenuEnum.defenses:
        onTabMenuHandler(TabsMenuEnum.backpacks, context);
        break;
      case TabsMenuEnum.backpacks:
        onTabMenuHandler(TabsMenuEnum.weapons, context);
        break;
      case TabsMenuEnum.weapons:
        onTabMenuHandler(TabsMenuEnum.orbital, context);
        break;
      case TabsMenuEnum.orbital:
        onTabMenuHandler(TabsMenuEnum.eagle, context);
        break;
    }
  }

  void onTabMenuHandler(TabsMenuEnum tabMenuSelected, BuildContext context) {
    final TabsMenuProvider tabMenuProvider = Provider.of<TabsMenuProvider>(context, listen: false);

    state.tabMenuSelected = tabMenuSelected;
    state.listToShow = _getListToShowByTabMenu();

    tabMenuProvider.notifyListeners();
    notifyListeners();
  }

  bool isSelected(StratagemModel stratagem) {
    return state.stratagemsSelectedForMission.any((String stratagemSelectedId) => stratagem.id == stratagemSelectedId);
  }

  void onStratagemsListItemTap(StratagemModel stratagem, BuildContext context) {
    final SelectedProvider selectedProvider = Provider.of<SelectedProvider>(context, listen: false);

    if (isSelected(stratagem)) {
      state.stratagemsSelectedForMission.remove(stratagem.id);
    } else if (state.stratagemsSelectedForMission.length < state.maxStratagemSelected) {
      state.stratagemsSelectedForMission.add(stratagem.id);
    }

    notifyListeners();
    selectedProvider.update();
  }

  void onSelectedIconTap(String stratagemId, BuildContext context) {
    state.stratagemsSelectedForMission.remove(stratagemId);

    final SelectedProvider selectedProvider = Provider.of<SelectedProvider>(context, listen: false);

    selectedProvider.update();
    notifyListeners();
  }

  StratagemModel getStratagemById(String stratagemId) {
    for (StratagemModel stratagem in state.stratagems) {
      if (stratagem.id == stratagemId) {
        return stratagem;
      }
    }

    throw Exception("Error en stratagemsProvider.getStratagemById: No se encontro la estratagema");
  }

  List<StratagemModel> _getListToShowByTabMenu() {
    switch (state.tabMenuSelected) {
      case TabsMenuEnum.backpacks:
        return state.backpacksStratagemsList;

      case TabsMenuEnum.defenses:
        return state.defensesStratagemsList;

      case TabsMenuEnum.eagle:
        return state.eagleStratagemsList;

      case TabsMenuEnum.orbital:
        return state.orbitalStratagemsList;

      case TabsMenuEnum.weapons:
        return state.weaponsStratagemsList;

      case TabsMenuEnum.mission:
        return state.missionStratagemsList;
    }
  }
}
