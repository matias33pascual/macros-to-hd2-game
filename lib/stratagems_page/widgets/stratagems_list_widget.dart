import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/shared/translation/translation_provider.dart';
import 'package:macros_to_helldivers/shared/ui/exports_shared.dart';
import 'package:macros_to_helldivers/stratagems_page/providers/exports_providers.dart';
import 'package:provider/provider.dart';

class StratagemsListWidget extends StatelessWidget {
  const StratagemsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StratagemsProvider provider =
        Provider.of<StratagemsProvider>(context);

    final TranslationProvider translationProvider =
        Provider.of<TranslationProvider>(context, listen: false);

    final listToShow = provider.state.listToShow;

    return GestureDetector(
      onHorizontalDragEnd: (details) =>
          provider.onHorizontalGestureHandler(details, context),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listToShow.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () =>
              provider.onStratagemsListItemTap(listToShow[index], context),
          child: Container(
            height: 32,
            margin: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: provider.isSelected(listToShow[index])
                  ? Colors.green.withValues(alpha: 0.6)
                  : const Color.fromARGB(137, 81, 95, 122),
              border: Border.all(
                color: provider.isSelected(listToShow[index])
                    ? Colors.green
                    : Colors.white.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (listToShow[index].icon.isNotEmpty)
                  Image.asset(listToShow[index].icon),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: CustomText(
                      textAlign: TextAlign.start,
                      text: translationProvider
                          .getTranslationOfStratagemName(listToShow[index].id),
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
