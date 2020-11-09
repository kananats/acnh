import 'package:acnh/dto/enum/enum.dart';
import 'package:acnh/dto/sea.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sea_filter_condition.g.dart';

@JsonSerializable(explicitToJson: true)
class SeaFilterCondition with EquatableMixin {
  @JsonKey(defaultValue: "")
  String keyword = "";

  @JsonKey(defaultValue: true)
  bool isNorth = true;

  @JsonKey(defaultValue: AvailabilityEnum.all)
  AvailabilityEnum availability = AvailabilityEnum.all;

  @JsonKey(defaultValue: false)
  bool hideCaught = false;

  @JsonKey(defaultValue: false)
  bool hideDonated = false;

  @JsonKey(defaultValue: false)
  bool hideAllYear = false;

  bool apply(Sea sea, DateTime dateTime, LanguageEnum language) {
    if (hideCaught && sea.isCaught) return false;
    if (hideDonated && sea.isDonated) return false;
    if (hideAllYear && sea.availability.isAvailableAllYear) return false;
    if (availability == AvailabilityEnum.now &&
        !sea.availability.isAvailableNow(dateTime, isNorth)) return false;
    if (availability == AvailabilityEnum.thisMonth &&
        !sea.availability.isAvailableThisMonth(dateTime, isNorth)) return false;
    if (!sea.name.of(language).contains(keyword.toLowerCase())) return false;

    return true;
  }

  SeaFilterCondition copy() => SeaFilterCondition()
    ..keyword = keyword
    ..isNorth = isNorth
    ..availability = availability
    ..hideCaught = hideCaught
    ..hideDonated = hideDonated
    ..hideAllYear = hideAllYear;

  static SeaFilterCondition fromJson(Map<String, dynamic> json) =>
      _$SeaFilterConditionFromJson(json);

  Map<String, dynamic> toJson() => _$SeaFilterConditionToJson(this);

  @override
  List<Object> get props => [
        keyword,
        isNorth,
        availability,
        hideCaught,
        hideDonated,
        hideAllYear,
      ];
}
