enum LanguagesEnum { spanish, english, portuguese, russian }

extension LanguagesEnumExtension on LanguagesEnum {
  String get code {
    switch (this) {
      case LanguagesEnum.english:
        return 'en';

      case LanguagesEnum.portuguese:
        return 'pt';

      case LanguagesEnum.russian:
        return 'ru';

      case LanguagesEnum.spanish:
      return 'es';
    }
  }

  static LanguagesEnum languageEnumFromCode(String code) {
    switch (code) {
      case "en":
        return LanguagesEnum.english;

      case "es":
        return LanguagesEnum.spanish;

      case "pt":
        return LanguagesEnum.portuguese;

      case 'ru':
        return LanguagesEnum.russian;

      default:
        throw Exception(
            "Error en LanguagesEnumExtension.langagueEnumFromCode: no se encontro el codigo del lenguage.");
    }
  }
}

class TranslationState {
  TranslationState._();

  static final TranslationState _instance = TranslationState._();

  static TranslationState get instance => _instance;

  LanguagesEnum currentLanguage = LanguagesEnum.spanish;

  Map<String, dynamic>? spanishTranslation;
  Map<String, dynamic>? englishTranslation;
  Map<String, dynamic>? portugueseTranslation;
  Map<String, dynamic>? russianTranslation;

  Map<String, dynamic>? stratagemsNamesInSpanish;
  Map<String, dynamic>? stratagemsNamesInEnglish;
  Map<String, dynamic>? stratagemsNamesInPortuguese;
  Map<String, dynamic>? stratagemsNamesInRussian;

  Map<String, dynamic>? get translation {
    switch (currentLanguage) {
      case LanguagesEnum.spanish:
        return spanishTranslation;

      case LanguagesEnum.portuguese:
        return portugueseTranslation;

      case LanguagesEnum.russian:
        return russianTranslation;

      case LanguagesEnum.english:
      return englishTranslation;
    }
  }
}
