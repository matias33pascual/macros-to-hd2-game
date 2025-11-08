import 'package:macros_to_helldivers/stratagems_page/models/tabs_menu_enum.dart';
import 'package:macros_to_helldivers/stratagems_page/models/stratagems_model.dart';

class StratagemsState {
  StratagemsState._();

  static final StratagemsState _instance = StratagemsState._();

  static StratagemsState get instance => _instance;

  List<StratagemModel> stratagems = [];

  List<StratagemModel> missionStratagemsList = [];
  List<StratagemModel> backpacksStratagemsList = [];
  List<StratagemModel> defensesStratagemsList = [];
  List<StratagemModel> eagleStratagemsList = [];
  List<StratagemModel> orbitalStratagemsList = [];
  List<StratagemModel> weaponsStratagemsList = [];

  TabsMenuEnum tabMenuSelected = TabsMenuEnum.eagle;

  List<StratagemModel> listToShow = [];

  List<String> stratagemsSelectedForMission = [
    "000",
    "001",
    "002",
  ];

  int maxStratagemSelected = 50;
}
