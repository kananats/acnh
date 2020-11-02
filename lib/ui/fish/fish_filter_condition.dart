import 'package:acnh/data/preferences.dart';
import 'package:acnh/dto/fish.dart';
import 'package:acnh/ui/fish/fish_filter_dialog.dart';
import 'package:equatable/equatable.dart';

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

  static FishFilterCondition fromPreferences(Preferences preferences) =>
      FishFilterCondition()
        ..isNorth = preferences[PreferencesKey.isNorth] ?? true
        ..availability = AvailabilityEnum
            .values[preferences[PreferencesKey.availability] ?? 0]
        ..hideCaught = preferences[PreferencesKey.hideCaught] ?? true
        ..hideDonated = preferences[PreferencesKey.hideDonated] ?? true
        ..hideAllYear = preferences[PreferencesKey.hideAllYear] ?? true;

  void toPreferences(Preferences preferences) {
    preferences[PreferencesKey.isNorth] = isNorth;
    preferences[PreferencesKey.availability] = availability.index;
    preferences[PreferencesKey.hideCaught] = hideCaught;
    preferences[PreferencesKey.hideDonated] = hideDonated;
    preferences[PreferencesKey.hideAllYear] = hideAllYear;
  }

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
