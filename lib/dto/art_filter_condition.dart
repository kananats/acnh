import 'package:acnh/dto/enum/enum.dart';
import 'package:acnh/dto/art.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'art_filter_condition.g.dart';

@JsonSerializable(explicitToJson: true)
class ArtFilterCondition with EquatableMixin {
  @JsonKey(defaultValue: "")
  String keyword = "";

  @JsonKey(defaultValue: false)
  bool hideDonated = false;

  bool apply(Art art, DateTime dateTime, LanguageEnum language) {
    if (hideDonated && art.isDonated) return false;
    if (!art.name.of(language).contains(keyword.toLowerCase())) return false;

    return true;
  }

  ArtFilterCondition copy() => ArtFilterCondition()
    ..keyword = keyword
    ..hideDonated = hideDonated;

  static ArtFilterCondition fromJson(Map<String, dynamic> json) =>
      _$ArtFilterConditionFromJson(json);

  Map<String, dynamic> toJson() => _$ArtFilterConditionToJson(this);

  @override
  List<Object> get props => [
        keyword,
        hideDonated,
      ];
}
