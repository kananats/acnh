import 'package:acnh/data/preferences.dart';
import 'package:acnh/dto/fish.dart';
import 'package:acnh/ui/fish/fish_filter_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fish_filter_condition.g.dart';

@JsonSerializable(explicitToJson: true)
class FishFilterCondition with EquatableMixin {
  String search = "";

  bool isNorth = true;
  AvailabilityEnum availability = AvailabilityEnum.all;

  bool hideCaught = false;
  bool hideDonated = false;
  bool hideAllYear = false;

  bool apply(Fish fish, DateTime dateTime) {
    if (hideCaught && fish.isCaught) return false;
    if (hideDonated && fish.isDonated) return false;
    if (hideAllYear && fish.availability.isAvailableAllYear) return false;
    if (availability == AvailabilityEnum.now &&
        !fish.availability.isAvailableNow(dateTime, isNorth)) return false;
    if (availability == AvailabilityEnum.thisMonth &&
        !fish.availability.isAvailableThisMonth(dateTime, isNorth))
      return false;
    if (!fish.name.name.contains(search)) return false;

    return true;
  }

  FishFilterCondition copy() => FishFilterCondition()
    ..search = search
    ..isNorth = isNorth
    ..availability = availability
    ..hideCaught = hideCaught
    ..hideDonated = hideDonated
    ..hideAllYear = hideAllYear;

  static FishFilterCondition fromJson(Map<String, dynamic> json) =>
      _$FishFilterConditionFromJson(json);

  Map<String, dynamic> toJson() => _$FishFilterConditionToJson(this);

  @override
  List<Object> get props => [
        search,
        isNorth,
        availability,
        hideCaught,
        hideDonated,
        hideAllYear,
      ];
}
