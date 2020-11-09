part of 'enum.dart';

enum LanguageEnum {
  USen,
  EUen,
  EUde,
  EUes,
  USes,
  EUfr,
  USfr,
  EUit,
  EUnl,
  CNzh,
  TWzh,
  JPja,
  KRko,
  EUru,
}

extension LanguageEnumExtension on LanguageEnum {
  String get name {
    switch (this) {
      case LanguageEnum.USen:
        return "English (US)";
      case LanguageEnum.EUen:
        return "English (Europe)";
      case LanguageEnum.EUde:
        return "Deutsch";
      case LanguageEnum.EUes:
        return "Español (Europe)";
      case LanguageEnum.USes:
        return "Español (Latinoamérica)";
      case LanguageEnum.EUfr:
        return "Français (Europe)";
      case LanguageEnum.USfr:
        return "Français (Canada)";
      case LanguageEnum.EUit:
        return "Italiano";
      case LanguageEnum.EUnl:
        return "Nederlands";
      case LanguageEnum.CNzh:
        return "简体中文";
      case LanguageEnum.TWzh:
        return "繁體中文";
      case LanguageEnum.JPja:
        return "日本語";
      case LanguageEnum.KRko:
        return "한국어";
      case LanguageEnum.EUru:
        return "Русский";
    }
    return "";
  }
}
