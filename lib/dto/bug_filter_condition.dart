import 'package:acnh/dto/availability.dart';
import 'package:acnh/dto/bug.dart';
import 'package:acnh/dto/language_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bug_filter_condition.g.dart';

@JsonSerializable(explicitToJson: true)
class BugFilterCondition with EquatableMixin {
  @JsonKey(ignore: true)
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

  bool apply(Bug bug, DateTime dateTime, LanguageEnum language) {
    if (hideCaught && bug.isCaught) return false;
    if (hideDonated && bug.isDonated) return false;
    if (hideAllYear && bug.availability.isAvailableAllYear) return false;
    if (availability == AvailabilityEnum.now &&
        !bug.availability.isAvailableNow(dateTime, isNorth)) return false;
    if (availability == AvailabilityEnum.thisMonth &&
        !bug.availability.isAvailableThisMonth(dateTime, isNorth)) return false;
    if (!bug.name.of(language).contains(keyword.toLowerCase())) return false;

    return true;
  }

  BugFilterCondition copy() => BugFilterCondition()
    ..keyword = keyword
    ..isNorth = isNorth
    ..availability = availability
    ..hideCaught = hideCaught
    ..hideDonated = hideDonated
    ..hideAllYear = hideAllYear;

  static BugFilterCondition fromJson(Map<String, dynamic> json) =>
      _$BugFilterConditionFromJson(json);

  Map<String, dynamic> toJson() => _$BugFilterConditionToJson(this);

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
