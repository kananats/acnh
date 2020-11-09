part of 'enum.dart';

enum PersonalityEnum {
  all,
  normal,
  lazy,
  sisterly,
  snooty,
  cranky,
  jock,
  peppy,
  smug,
}

extension PersonalityEnumExtension on PersonalityEnum {
  String get name {
    switch (this) {
      case PersonalityEnum.all:
        return "All";
      case PersonalityEnum.normal:
        return "Normal";
      case PersonalityEnum.lazy:
        return "Lazy";
      case PersonalityEnum.sisterly:
        return "Sisterly";
      case PersonalityEnum.snooty:
        return "Snooty";
      case PersonalityEnum.cranky:
        return "Cranky";
      case PersonalityEnum.jock:
        return "Jock";
      case PersonalityEnum.peppy:
        return "Peppy";
      case PersonalityEnum.smug:
        return "Smug";
    }
    return "";
  }
}
