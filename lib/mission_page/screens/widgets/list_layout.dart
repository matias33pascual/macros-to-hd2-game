import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/mission_page/screens/widgets/exports_widgets.dart';
import 'package:macros_to_helldivers/stratagems_page/models/stratagems_model.dart';

class ListLayout extends StatelessWidget {
  const ListLayout({Key? key, required this.stratagemsList}) : super(key: key);

  final List<StratagemModel> stratagemsList;

  @override
  Widget build(BuildContext context) {
    List<Widget> stratagemsListWidgets = _buildListLayout(stratagemsList);

    return ListView(
      children: stratagemsListWidgets,
    );
  }

  List<Widget> _buildListLayout(List<StratagemModel> stratagemsList) {
    List<Widget> stratagemsListWidgets = [];

    stratagemsListWidgets = stratagemsList.map((stratagem) {
      return StratagemListButton(stratagem: stratagem);
    }).toList();

    return stratagemsListWidgets;
  }
}
