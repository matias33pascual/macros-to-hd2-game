import 'package:flutter/cupertino.dart';
import 'package:macros_to_helldivers/shared/translation/translation_provider.dart';
import 'package:provider/provider.dart';

enum TabsMenuEnum { mission, defenses, eagle, orbital, weapons, backpacks }

extension TabMenuEnumExtension on TabsMenuEnum {
  String getStringValue(BuildContext context) {
    final TranslationProvider provider = Provider.of<TranslationProvider>(context);

    switch (this) {
      case TabsMenuEnum.mission:
        return provider.translationTextOf?["stratagems_mission"];
      case TabsMenuEnum.defenses:
        return provider.translationTextOf?["stratagems_defenses"];
      case TabsMenuEnum.eagle:
        return provider.translationTextOf?["stratagems_eagle"];
      case TabsMenuEnum.orbital:
        return provider.translationTextOf?["stratagems_orbital"];
      case TabsMenuEnum.weapons:
        return provider.translationTextOf?["stratagems_weapons"];
      case TabsMenuEnum.backpacks:
        return provider.translationTextOf?["stratagems_backpacks"];
    }
  }
}
