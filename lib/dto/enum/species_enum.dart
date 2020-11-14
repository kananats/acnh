part of 'enum.dart';

enum SpeciesEnum {
  all,
  anteater,
  bear,
  bird,
  bull,
  cat,
  cub,
  chicken,
  cow,
  alligator,
  deer,
  dog,
  duck,
  eagle,
  elephant,
  frog,
  goat,
  gorilla,
  hamster,
  hippo,
  horse,
  koala,
  kangaroo,
  lion,
  monkey,
  mouse,
  octopus,
  ostrich,
  penguin,
  pig,
  rabbit,
  rhino,
  sheep,
  squirrel,
  tiger,
  wolf,
}

extension SpeciesEnumExtension on SpeciesEnum {
  String get name {
    switch (this) {
      case SpeciesEnum.all:
        return "All";
      case SpeciesEnum.anteater:
        return "Anteater";
      case SpeciesEnum.bear:
        return "Bear";
      case SpeciesEnum.bird:
        return "Bird";
      case SpeciesEnum.bull:
        return "Bull";
      case SpeciesEnum.cat:
        return "Cat";
      case SpeciesEnum.cub:
        return "Cub";
      case SpeciesEnum.chicken:
        return "Chicken";
      case SpeciesEnum.cow:
        return "Cow";
      case SpeciesEnum.alligator:
        return "Alligator";
      case SpeciesEnum.deer:
        return "Deer";
      case SpeciesEnum.dog:
        return "Dog";
      case SpeciesEnum.duck:
        return "Duck";
      case SpeciesEnum.eagle:
        return "Eagle";
      case SpeciesEnum.elephant:
        return "Elephant";
      case SpeciesEnum.frog:
        return "Frog";
      case SpeciesEnum.goat:
        return "Goat";
      case SpeciesEnum.gorilla:
        return "Gorilla";
      case SpeciesEnum.hamster:
        return "Hamster";
      case SpeciesEnum.hippo:
        return "Hippo";
      case SpeciesEnum.horse:
        return "Horse";
      case SpeciesEnum.koala:
        return "Koala";
      case SpeciesEnum.kangaroo:
        return "Kangaroo";
      case SpeciesEnum.lion:
        return "Lion";
      case SpeciesEnum.monkey:
        return "Monkey";
      case SpeciesEnum.mouse:
        return "Mouse";
      case SpeciesEnum.octopus:
        return "Octopus";
      case SpeciesEnum.ostrich:
        return "Ostrich";
      case SpeciesEnum.penguin:
        return "Penguin";
      case SpeciesEnum.pig:
        return "Pig";
      case SpeciesEnum.rabbit:
        return "Rabbit";
      case SpeciesEnum.rhino:
        return "Rhino";
      case SpeciesEnum.sheep:
        return "Sheep";
      case SpeciesEnum.squirrel:
        return "Squirrel";
      case SpeciesEnum.tiger:
        return "Tiger";
      case SpeciesEnum.wolf:
        return "Wolf";
    }
    return "";
  }
}
