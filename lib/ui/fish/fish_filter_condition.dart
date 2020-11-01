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

  bool apply(Fish fish) {
    return fish.name.contains(search);
  }

  FishFilterCondition copy() => FishFilterCondition()
    ..search = search
    ..isNorth = isNorth
    ..availability = availability
    ..hideCaught = hideCaught
    ..hideDonated = hideDonated
    ..hideAllYear = hideAllYear;

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
