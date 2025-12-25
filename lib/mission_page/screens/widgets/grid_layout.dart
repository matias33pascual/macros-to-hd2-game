import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/mission_page/screens/widgets/exports_widgets.dart';
import 'package:macros_to_helldivers/stratagems_page/models/stratagems_model.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({
    super.key,
    required this.stratagemsList,
  });

  final List<StratagemModel> stratagemsList;

  @override
  Widget build(BuildContext context) {
    return _buildGrid(stratagemsList);
  }

  Widget _buildGrid(List<StratagemModel> stragemsList) {
    final List<Widget> stratagemsWidgetsList = [];
    for (var i = 0; i < stratagemsList.length; i++) {
      stratagemsWidgetsList.add(
        Flexible(
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: StratagemGridButton(stratagem: stratagemsList[i]),
              ),
              if (i + 1 < stratagemsList.length)
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: StratagemGridButton(stratagem: stratagemsList[++i]),
                ),
            ],
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stratagemsWidgetsList,
    );
  }
}
