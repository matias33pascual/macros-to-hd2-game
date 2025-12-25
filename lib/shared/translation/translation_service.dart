import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:macros_to_helldivers/shared/translation/translation_state.dart';

class TranslationService {
  TranslationService._();

  static final TranslationService _instance = TranslationService._();

  static TranslationService get instance => _instance;

  Future<dynamic> loadLanguages(String currentLanguage) async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/languages/$currentLanguage.json');

      final translations = await json.decode(jsonString);

      return translations;
    } catch (error) {
      if (kDebugMode) {
        print("Error en TranslationService: $error");
      }
    }
  }

  Future<dynamic> loadStratagemsNameByLanguage(LanguagesEnum languages) async {
    try {
      String jsonString = await rootBundle
          .loadString('assets/languages/stratagems_${languages.code}.json');

      final translation = await json.decode(jsonString);

      return translation;
    } catch (error) {
      if (kDebugMode) {
        print("Error en TranslationService: $error");
      }
    }
  }
}
