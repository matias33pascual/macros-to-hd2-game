import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/mission_page/providers/mission_provider.dart';
import 'package:macros_to_helldivers/mission_page/screens/widgets/exports_widgets.dart';
import 'package:macros_to_helldivers/stratagems_page/models/stratagems_model.dart';
import 'package:macros_to_helldivers/stratagems_page/providers/exports_providers.dart';
import 'package:provider/provider.dart';

class MissionStratagems extends StatelessWidget {
  const MissionStratagems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StratagemsProvider provider = Provider.of<StratagemsProvider>(context, listen: false);

    final List<StratagemModel> stratagemsList = provider.state.stratagemsSelectedForMission
        .map((stratagemId) => provider.getStratagemById(stratagemId))
        .toList();

    return _buildLayout(stratagemsList, context);
  }
}

Widget _buildLayout(List<StratagemModel> stratagemsList, BuildContext context) {
  final MissionProvider provider = Provider.of<MissionProvider>(context);

  if (stratagemsList.isEmpty) {
    return Container();
  }

  return GridView.count(
    crossAxisCount: provider.state.buttonsForRow.toInt(),
    children: stratagemsList.map((stratagem) => StratagemGridButton(stratagem: stratagem)).toList(),
  );
}
