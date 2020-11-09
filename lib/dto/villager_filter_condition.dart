import 'package:acnh/dto/enum/enum.dart';
import 'package:acnh/dto/villager.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'villager_filter_condition.g.dart';

@JsonSerializable(explicitToJson: true)
class VillagerFilterCondition with EquatableMixin {
  @JsonKey(defaultValue: "")
  String keyword = "";

  @JsonKey(defaultValue: PersonalityEnum.all)
  PersonalityEnum personality;

  bool apply(Villager villager, LanguageEnum language) {
    if (personality != PersonalityEnum.all &&
        villager.personality.toLowerCase() != personality.name.toLowerCase())
      return false;

    if (!villager.name.of(language).toLowerCase().contains(
          keyword.toLowerCase(),
        )) return false;

    return true;
  }

  VillagerFilterCondition copy() => VillagerFilterCondition()
    ..keyword = keyword
    ..personality = personality;

  static VillagerFilterCondition fromJson(Map<String, dynamic> json) =>
      _$VillagerFilterConditionFromJson(json);

  Map<String, dynamic> toJson() => _$VillagerFilterConditionToJson(this);

  @override
  List<Object> get props => [
        keyword,
        personality,
      ];
}
