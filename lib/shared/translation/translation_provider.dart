import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:macros_to_helldivers/shared/translation/translation_service.dart';
import 'package:macros_to_helldivers/shared/translation/translation_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationProvider extends ChangeNotifier {
  TranslationService service = TranslationService.instance;
  TranslationState state = TranslationState.instance;

  Future<void> init(BuildContext context) async {
    await loadLanguageFiles().then(
      (_) => getCurrentLanguage(),
    );
  }

  Future loadLanguageFiles() async {
    state.spanishTranslation = await service.loadLanguages(LanguagesEnum.spanish.code);

    state.portugueseTranslation = await service.loadLanguages(LanguagesEnum.portuguese.code);

    state.englishTranslation = await service.loadLanguages(LanguagesEnum.english.code);

    state.russianTranslation = await service.loadLanguages(LanguagesEnum.russian.code);

    state.stratagemsNamesInSpanish = await service.loadStratagemsNameByLanguage(LanguagesEnum.spanish);

    state.stratagemsNamesInEnglish = await service.loadStratagemsNameByLanguage(LanguagesEnum.english);

    state.stratagemsNamesInPortuguese = await service.loadStratagemsNameByLanguage(LanguagesEnum.portuguese);

    state.stratagemsNamesInRussian = await service.loadStratagemsNameByLanguage(LanguagesEnum.russian);
  }

  Map<String, dynamic>? get translationTextOf {
    return state.translation;
  }

  dynamic getTranslationOfStratagemName(String stratagemId) {
    switch (state.currentLanguage) {
      case LanguagesEnum.spanish:
        return state.stratagemsNamesInSpanish?[stratagemId] ?? "";

      case LanguagesEnum.english:
        return state.stratagemsNamesInEnglish?[stratagemId] ?? "";

      case LanguagesEnum.portuguese:
        return state.stratagemsNamesInPortuguese?[stratagemId] ?? "";

      case LanguagesEnum.russian:
        return state.stratagemsNamesInRussian?[stratagemId] ?? "";

      }
  }

  Future setCurrentLanguage(LanguagesEnum language) async {
    state.currentLanguage = language;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      "language",
      jsonEncode(language.code),
    );

    notifyListeners();
  }

  Future getCurrentLanguage() async {
    await SharedPreferences.getInstance().then(
      (prefs) {
        String? value = prefs.getString("language");

        if (value != null) {
          final String languageCode = jsonDecode(value);

          final LanguagesEnum defaultLanguageSelected = LanguagesEnumExtension.languageEnumFromCode(languageCode);

          setCurrentLanguage(defaultLanguageSelected);
        } else {
          setCurrentLanguage(LanguagesEnum.english);
        }

        notifyListeners();
      },
    );
  }

  Image get flagIcon {
    switch (state.currentLanguage) {
      case LanguagesEnum.portuguese:
        return Image.asset("assets/images/flag-brasil.webp");

      case LanguagesEnum.russian:
        return Image.asset("assets/images/flag-rusia.webp");

      case LanguagesEnum.english:
        return Image.asset("assets/images/flag-usa.webp");

      case LanguagesEnum.spanish:
      return Image.asset("assets/images/flag-argentina.webp");
    }
  }
}
