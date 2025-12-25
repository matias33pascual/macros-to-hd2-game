import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/shared/ui/exports_shared.dart';
import 'package:macros_to_helldivers/stratagems_page/models/tabs_menu_enum.dart';
import 'package:macros_to_helldivers/stratagems_page/providers/exports_providers.dart';
import 'package:provider/provider.dart';

class TabMenuWidget extends StatelessWidget {
  const TabMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TabsMenuProvider tabsMenuProviders = Provider.of<TabsMenuProvider>(context);

    final StratagemsProvider stratagemsProvider = Provider.of<StratagemsProvider>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _MenuTab(
          text: TabsMenuEnum.mission.getStringValue(context),
          isSelected: tabsMenuProviders.isThisMenuSelected(TabsMenuEnum.mission),
          onTapHandler: () => stratagemsProvider.onTabMenuHandler(TabsMenuEnum.mission, context),
        ),
        _MenuTab(
          text: TabsMenuEnum.eagle.getStringValue(context),
          isSelected: tabsMenuProviders.isThisMenuSelected(TabsMenuEnum.eagle),
          onTapHandler: () => stratagemsProvider.onTabMenuHandler(TabsMenuEnum.eagle, context),
        ),
        _MenuTab(
          text: TabsMenuEnum.orbital.getStringValue(context),
          isSelected: tabsMenuProviders.isThisMenuSelected(TabsMenuEnum.orbital),
          onTapHandler: () => stratagemsProvider.onTabMenuHandler(TabsMenuEnum.orbital, context),
        ),
        _MenuTab(
          text: TabsMenuEnum.weapons.getStringValue(context),
          isSelected: tabsMenuProviders.isThisMenuSelected(TabsMenuEnum.weapons),
          onTapHandler: () => stratagemsProvider.onTabMenuHandler(TabsMenuEnum.weapons, context),
        ),
        _MenuTab(
          text: TabsMenuEnum.backpacks.getStringValue(context),
          isSelected: tabsMenuProviders.isThisMenuSelected(TabsMenuEnum.backpacks),
          onTapHandler: () => stratagemsProvider.onTabMenuHandler(TabsMenuEnum.backpacks, context),
        ),
        _MenuTab(
          text: TabsMenuEnum.defenses.getStringValue(context),
          isSelected: tabsMenuProviders.isThisMenuSelected(TabsMenuEnum.defenses),
          onTapHandler: () => stratagemsProvider.onTabMenuHandler(TabsMenuEnum.defenses, context),
        ),
      ],
    );
  }
}

class _MenuTab extends StatelessWidget {
  final bool isSelected;
  final String text;
  final void Function()? onTapHandler;

  const _MenuTab({required this.text, required this.isSelected, required this.onTapHandler});

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return CustomText(text: text, strokeColor: Colors.black, textColor: Colors.amber, size: 12);
    }

    return InkWell(
      onTap: onTapHandler,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: CustomText(text: text, size: 10.5),
      ),
    );
  }
}
