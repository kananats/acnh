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
        return "English (UK)";
      case LanguageEnum.EUde:
        return "German";
      case LanguageEnum.EUes:
        return "Spanish";
      case LanguageEnum.USes:
        return "Spanish";
      case LanguageEnum.EUfr:
        return "French";
      case LanguageEnum.USfr:
        return "Canadian French";
      case LanguageEnum.EUit:
        return "Italian";
      case LanguageEnum.EUnl:
        return "Dutch";
      case LanguageEnum.CNzh:
        return "Chinese";
      case LanguageEnum.TWzh:
        return "Cantonese";
      case LanguageEnum.JPja:
        return "Japanese";
      case LanguageEnum.KRko:
        return "Korean";
      case LanguageEnum.EUru:
        return "Russian";
    }
    return "";
  }
}
