import 'package:acnh/util/string_util.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'availability.g.dart';

@JsonSerializable(explicitToJson: true)
class Availability with EquatableMixin {
  String location;
  String rarity;

  @JsonKey(name: "month-array-northern")
  List<int> monthArrayNorthern;

  @JsonKey(name: "month-array-southern")
  List<int> monthArraySouthern;

  @JsonKey(name: "time-array")
  List<int> timeArray;

  static Availability fromJson(Map<String, dynamic> json) =>
      _$AvailabilityFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabilityToJson(this);

  @override
  List<Object> get props => [
        location,
        rarity,
        monthArrayNorthern,
        monthArraySouthern,
        timeArray,
      ];

  String get availableTime => StringUtil.formatTimeArray(timeArray).join(", ");

  String availableMonth(bool isNorth) => StringUtil.formatMonthArray(
        isNorth ? monthArrayNorthern : monthArraySouthern,
      ).join(", ");

  bool isAvailableNow(DateTime dateTime, bool isNorth) =>
      isAvailableThisMonth(dateTime, isNorth) && isAvailableThisTime(dateTime);

  bool isAvailableThisMonth(DateTime dateTime, bool isNorth) =>
      _monthArray(isNorth).contains(dateTime.month);

  bool isAvailableThisTime(DateTime dateTime) =>
      timeArray.contains(dateTime.hour);

  bool get isAvailableAllYear =>
      monthArrayNorthern.length >= 12 && monthArraySouthern.length >= 12;

  List<int> _monthArray(bool isNorth) =>
      isNorth ? monthArrayNorthern : monthArraySouthern;
}
