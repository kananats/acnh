import 'package:acnh/dto/language_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';

@JsonSerializable(explicitToJson: true)
class Setting with EquatableMixin {
  @JsonKey(defaultValue: LanguageEnum.USen)
  LanguageEnum language;

  Duration dateTimeOffset;
  DateTime freezedDateTime;

  bool get isFreezed => freezedDateTime != null;

  Setting copy() => Setting()
    ..language = language
    ..dateTimeOffset = dateTimeOffset
    ..freezedDateTime = freezedDateTime;

  static Setting fromJson(Map<String, dynamic> json) => _$SettingFromJson(json);

  Map<String, dynamic> toJson() => _$SettingToJson(this);

  @override
  List<Object> get props => [language, dateTimeOffset, freezedDateTime];
}
