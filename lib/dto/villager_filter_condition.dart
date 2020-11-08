import 'package:acnh/dto/villager.dart';
import 'package:acnh/dto/language_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'villager_filter_condition.g.dart';

@JsonSerializable(explicitToJson: true)
class VillagerFilterCondition with EquatableMixin {
  @JsonKey(defaultValue: "")
  String keyword = "";

  // TODO

  bool apply(Villager villager, DateTime dateTime, LanguageEnum language) {
    if (!villager.name.of(language).toLowerCase().contains(
          keyword.toLowerCase(),
        )) return false;

    return true;
  }

  VillagerFilterCondition copy() =>
      VillagerFilterCondition()..keyword = keyword;

  static VillagerFilterCondition fromJson(Map<String, dynamic> json) =>
      _$VillagerFilterConditionFromJson(json);

  Map<String, dynamic> toJson() => _$VillagerFilterConditionToJson(this);

  @override
  List<Object> get props => [
        keyword,
      ];
}
