import 'package:acnh/dto/enum/enum.dart';
import 'package:acnh/dto/villager.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'villager_filter_condition.g.dart';

@JsonSerializable(explicitToJson: true)
class VillagerFilterCondition with EquatableMixin {
  @JsonKey(defaultValue: "")
  String keyword = "";

  @JsonKey(defaultValue: SpeciesEnum.all)
  SpeciesEnum species;

  @JsonKey(defaultValue: PersonalityEnum.all)
  PersonalityEnum personality;

  @JsonKey(defaultValue: SelectionEnum.all)
  SelectionEnum residentSelection;

  @JsonKey(defaultValue: SelectionEnum.all)
  SelectionEnum favoriteSelection;

  bool apply(Villager villager, LanguageEnum language) {
    if (species != SpeciesEnum.all &&
        villager.species.toLowerCase() != species.name.toLowerCase())
      return false;

    if (personality != PersonalityEnum.all &&
        villager.personality.toLowerCase() != personality.name.toLowerCase())
      return false;

    if (!villager.name.of(language).toLowerCase().contains(
          keyword.toLowerCase(),
        )) return false;

    if (residentSelection == SelectionEnum.only && !villager.isResident)
      return false;

    if (residentSelection == SelectionEnum.none && villager.isResident)
      return false;

    if (favoriteSelection == SelectionEnum.only && !villager.isFavorite)
      return false;

    if (favoriteSelection == SelectionEnum.none && villager.isFavorite)
      return false;

    return true;
  }

  VillagerFilterCondition copy() => VillagerFilterCondition()
    ..keyword = keyword
    ..species = species
    ..personality = personality
    ..residentSelection = residentSelection
    ..favoriteSelection = favoriteSelection;

  static VillagerFilterCondition fromJson(Map<String, dynamic> json) =>
      _$VillagerFilterConditionFromJson(json);

  Map<String, dynamic> toJson() => _$VillagerFilterConditionToJson(this);

  @override
  List<Object> get props => [
        keyword,
        personality,
      ];
}
