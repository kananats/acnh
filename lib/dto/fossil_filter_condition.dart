import 'package:acnh/dto/enum/enum.dart';
import 'package:acnh/dto/fossil.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fossil_filter_condition.g.dart';

@JsonSerializable(explicitToJson: true)
class FossilFilterCondition with EquatableMixin {
  @JsonKey(defaultValue: "")
  String keyword = "";

  @JsonKey(defaultValue: false)
  bool hideDonated = false;

  bool apply(Fossil fossil, DateTime dateTime, LanguageEnum language) {
    if (hideDonated && fossil.isDonated) return false;
    if (!fossil.name.of(language).contains(keyword.toLowerCase())) return false;

    return true;
  }

  FossilFilterCondition copy() => FossilFilterCondition()
    ..keyword = keyword
    ..hideDonated = hideDonated;

  static FossilFilterCondition fromJson(Map<String, dynamic> json) =>
      _$FossilFilterConditionFromJson(json);

  Map<String, dynamic> toJson() => _$FossilFilterConditionToJson(this);

  @override
  List<Object> get props => [
        keyword,
        hideDonated,
      ];
}
